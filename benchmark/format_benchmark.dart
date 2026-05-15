import 'dart:io';

import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Format/Formatter.dart';

typedef _Sample = ({String path, String source});

/// Microbenchmark for [Formatter.format].
///
/// Usage: dart run benchmark/format_benchmark.dart [dir] [--iterations=N] [--warmup=N] [--profile] [--breakdown]
/// Defaults: dir=lib/src, warmup=3, iterations=10.
///
/// `--profile` pauses for DevTools attach. Run under the VM service:
///   dart run --observe=8181 --pause-isolates-on-exit benchmark/format_benchmark.dart --profile
///
/// `--breakdown` runs an extra pass over the corpus and reports per-phase
/// timings (normalize / parse / visit / tidyBlankLines / verify / crlfRestore).
class FormatBenchmark
{
    static const String _BREAKDOWN_FLAG = '--breakdown';
    static const String _DEFAULT_DIRECTORY = 'lib/src';
    static const int _DEFAULT_ITERATIONS = 10;
    static const int _DEFAULT_WARMUP = 3;
    static const String _PROFILE_FLAG = '--profile';

    static Future<void> run(List<String> args)
    async
    {
        final String directory = args.firstWhere((String a) => !a.startsWith('--'), orElse: () => _DEFAULT_DIRECTORY);
        final int iterations = _parseIntFlag(args, '--iterations', _DEFAULT_ITERATIONS);
        final int warmup = _parseIntFlag(args, '--warmup', _DEFAULT_WARMUP);
        final bool profile = args.contains(_PROFILE_FLAG);
        final bool breakdown = args.contains(_BREAKDOWN_FLAG);

        final List<_Sample> corpus = _loadCorpus(directory);
        if (corpus.isEmpty)
        {
            stderr.writeln('No .dart files found under "$directory".');
            exitCode = 1;
            return;
        }

        final int totalChars = corpus.fold<int>(0, (int sum, _Sample s) => sum + s.source.length);
        stdout.writeln('Corpus:    ${corpus.length} file(s), $totalChars char(s) from "$directory"');
        stdout.writeln('Warmup:    $warmup iteration(s)');
        stdout.writeln('Measured:  $iterations iteration(s)');
        if (profile)
            stdout.writeln('Profile:   on (will pause before/after measured runs)');
        stdout.writeln();

        final Formatter formatter = Formatter(Config.experimental());

        for (int i = 0; i < warmup; i++)
            _runFullCorpus(formatter, corpus);

        if (profile)
            _waitForEnter('Warmup done. Attach DevTools, start CPU sampling, then press Enter to run measured iterations...');

        final List<int> microsecondsPerIteration = <int>[];
        for (int i = 0; i < iterations; i++)
            microsecondsPerIteration.add(_runFullCorpus(formatter, corpus));

        if (profile)
            _waitForEnter('Measured runs done. Stop CPU sampling and inspect the profile in DevTools, then press Enter to exit...');

        _reportAggregate(microsecondsPerIteration, totalChars);
        _reportSlowestFiles(formatter, corpus);
        if (breakdown)
            _reportBreakdown(formatter, corpus);
    }

    static String _formatMicroseconds(int microseconds)
    => '${(microseconds / 1000).toStringAsFixed(2)} ms';

    static List<_Sample> _loadCorpus(String directory)
    {
        final Directory dir = Directory(directory);
        if (!dir.existsSync())
            throw FileSystemException('Directory not found', directory);

        final List<_Sample> samples = <_Sample>[];
        for (final FileSystemEntity entity in dir.listSync(recursive: true, followLinks: false))
        {
            if (entity is! File)
                continue;
            final String path = entity.path;
            if (!path.endsWith('.dart'))
                continue;
            if (path.endsWith('.g.dart') || path.endsWith('.freezed.dart') || path.endsWith('.mocks.dart'))
                continue;
            samples.add((path: path, source: entity.readAsStringSync()));
        }
        samples.sort((_Sample a, _Sample b) => a.path.compareTo(b.path));
        return samples;
    }

    static int _parseIntFlag(List<String> args, String name, int defaultValue)
    {
        final String prefix = '$name=';
        for (final String arg in args)
        {
            if (arg.startsWith(prefix))
                return int.parse(arg.substring(prefix.length));
        }
        return defaultValue;
    }

    static void _reportAggregate(List<int> microsecondsPerIteration, int totalChars)
    {
        final List<int> sorted = List<int>.from(microsecondsPerIteration)..sort();
        final int min = sorted.first;
        final int max = sorted.last;
        final int median = sorted[sorted.length ~/ 2];
        final int p95 = sorted[((sorted.length - 1) * 95 / 100).round()];
        final double mean = sorted.reduce((int a, int b) => a + b) / sorted.length;
        final double medianMsPerKChar = (median / 1000) / (totalChars / 1000);

        stdout.writeln('Per-iteration wall time (full corpus):');
        stdout.writeln('  min:    ${_formatMicroseconds(min)}');
        stdout.writeln('  median: ${_formatMicroseconds(median)}');
        stdout.writeln('  mean:   ${_formatMicroseconds(mean.round())}');
        stdout.writeln('  p95:    ${_formatMicroseconds(p95)}');
        stdout.writeln('  max:    ${_formatMicroseconds(max)}');
        stdout.writeln();
        stdout.writeln('Median throughput: ${medianMsPerKChar.toStringAsFixed(3)} ms/kChar');
        stdout.writeln();
    }

    static void _reportBreakdown(Formatter formatter, List<_Sample> corpus)
    {
        final Map<String, int> phaseMicroseconds = <String, int>{};
        final Stopwatch totalStopwatch = Stopwatch()..start();
        for (final _Sample sample in corpus)
            formatter.format(sample.source, phaseMicroseconds: phaseMicroseconds);
        totalStopwatch.stop();

        final int summed = phaseMicroseconds.values.fold<int>(0, (int a, int b) => a + b);
        final int total = totalStopwatch.elapsedMicroseconds;

        stdout.writeln('Per-phase breakdown (single pass over corpus):');
        const List<String> phaseOrder = <String>['normalize', 'parse', 'visit', 'tidyBlankLines', 'verify', 'crlfRestore'];
        for (final String phase in phaseOrder)
        {
            final int micros = phaseMicroseconds[phase] ?? 0;
            final double percent = total == 0 ? 0 : (micros / total) * 100;
            stdout.writeln('  ${phase.padRight(15)} ${_formatMicroseconds(micros).padLeft(10)}  ${percent.toStringAsFixed(1).padLeft(5)} %');
        }
        final int unaccounted = total - summed;
        final double unaccountedPercent = total == 0 ? 0 : (unaccounted / total) * 100;
        stdout.writeln('  ${'(other)'.padRight(15)} ${_formatMicroseconds(unaccounted).padLeft(10)}  ${unaccountedPercent.toStringAsFixed(1).padLeft(5)} %');
        stdout.writeln('  ${'TOTAL'.padRight(15)} ${_formatMicroseconds(total).padLeft(10)}');
        stdout.writeln();
    }

    static void _reportSlowestFiles(Formatter formatter, List<_Sample> corpus)
    {
        final List<({String path, int chars, int microseconds, double msPerKChar})> rows = <({String path, int chars, int microseconds, double msPerKChar})>[];
        for (final _Sample sample in corpus)
        {
            final Stopwatch stopwatch = Stopwatch()..start();
            formatter.format(sample.source);
            stopwatch.stop();
            final int micros = stopwatch.elapsedMicroseconds;
            final double msPerKChar = sample.source.isEmpty ? 0 : (micros / 1000) / (sample.source.length / 1000);
            rows.add((path: sample.path, chars: sample.source.length, microseconds: micros, msPerKChar: msPerKChar));
        }

        rows.sort((({String path, int chars, int microseconds, double msPerKChar}) a, ({String path, int chars, int microseconds, double msPerKChar}) b)
            => b.msPerKChar.compareTo(a.msPerKChar)
        );

        final int topCount = rows.length < 10 ? rows.length : 10;
        stdout.writeln('Top $topCount slowest files (by ms/kChar, single run):');
        for (int i = 0; i < topCount; i++)
        {
            final ({String path, int chars, int microseconds, double msPerKChar}) row = rows[i];
            stdout.writeln('  ${row.msPerKChar.toStringAsFixed(3).padLeft(7)} ms/kChar  '
                '${_formatMicroseconds(row.microseconds).padLeft(10)}  '
                '${row.chars.toString().padLeft(7)} chars  '
                '${row.path}');
        }
    }

    /// Returns microseconds elapsed for one full pass over the corpus.
    static int _runFullCorpus(Formatter formatter, List<_Sample> corpus)
    {
        final Stopwatch stopwatch = Stopwatch()..start();
        for (final _Sample sample in corpus)
            formatter.format(sample.source);
        stopwatch.stop();
        return stopwatch.elapsedMicroseconds;
    }

    static void _waitForEnter(String message)
    {
        stdout.writeln();
        stdout.writeln(message);
        stdin.readLineSync();
    }
}

Future<void> main(List<String> args)
=> FormatBenchmark.run(args);
