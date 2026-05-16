import 'dart:io';

import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';

import '../Exceptions/DartFormatException.dart';

class FileResolver
{
    static const String CLASS_NAME = 'FileResolver';

    /// Glob patterns that are excluded by default. Applied during directory
    /// recursion and glob expansion. Explicit file paths bypass these.
    static const List<String> DEFAULT_EXCLUDES = <String>[
        // Folders.
        '**/.*/**',
        '**/build/**',

        // Codegen suffixes - core.
        '**/*.g.dart',
        '**/*.freezed.dart',
        '**/*.mocks.dart',

        // Codegen suffixes - extended.
        '**/*.chopper.dart',
        '**/*.config.dart',
        '**/*.gen.dart',
        '**/*.gr.dart',
        '**/*.pb.dart',
        '**/*.pbenum.dart',
        '**/*.pbjson.dart',
        '**/*.pbgrpc.dart',
        '**/*.swagger.dart'
    ];

    /// Resolves CLI positional inputs into a sorted, deduplicated list of
    /// `.dart` file paths to format. Paths are normalised to forward slashes.
    ///
    /// Each [inputs] entry may be a file, a directory (recursed), or a glob
    /// pattern. [userExcludes] are glob patterns supplied via `--exclude`.
    /// Default + user excludes apply to directory/glob expansion. Explicit
    /// file paths bypass [DEFAULT_EXCLUDES] but still honour [userExcludes].
    ///
    /// Throws [DartFormatException] if an explicit path is not a `.dart`
    /// file, or if any input path does not exist.
    static List<String> resolve({
        required List<String> inputs,
        List<String> userExcludes = const <String>[]
    })
    {
        final List<RegExp> userExcludeRegexes = userExcludes.map(_compilePattern).toList();
        final List<RegExp> defaultExcludeRegexes = DEFAULT_EXCLUDES.map(_compilePattern).toList();
        final List<RegExp> allExcludeRegexes = <RegExp>[...defaultExcludeRegexes, ...userExcludeRegexes];

        final Set<String> resolved = <String>{};

        for (final String input in inputs)
        {
            if (_isGlob(input))
            {
                resolved.addAll(_expandGlob(input, allExcludeRegexes));
                continue;
            }

            final FileSystemEntityType type = FileSystemEntity.typeSync(input);

            if (type == FileSystemEntityType.directory)
            {
                resolved.addAll(_expandDirectory(input, allExcludeRegexes));
                continue;
            }

            if (type == FileSystemEntityType.file)
            {
                if (!input.endsWith('.dart'))
                    throw DartFormatException.error('Not a Dart file: $input');

                final String normalised = _normalise(input);
                if (!_isExcluded(normalised, userExcludeRegexes))
                    resolved.add(normalised);

                continue;
            }

            throw DartFormatException.error('Path does not exist: $input');
        }

        final List<String> result = resolved.toList()..sort();
        return result;
    }

    /// Translates a glob pattern into an anchored [RegExp] using
    /// POSIX-style globbing semantics:
    ///   - `**` matches any number of characters including `/`.
    ///   - `**/` may match zero path segments.
    ///   - `*` matches any number of characters except `/`.
    ///   - `?` matches a single character except `/`.
    ///
    /// This deliberately replaces `Glob.matches` because the latter fails on
    /// absolute Windows-style paths (e.g. `C:/Users/...`).
    static RegExp _compilePattern(String pattern)
    {
        final StringBuffer buf = StringBuffer('^');
        int i = 0;

        while (i < pattern.length)
        {
            final String c = pattern[i];
            if (c == '*' && i + 1 < pattern.length && pattern[i + 1] == '*')
            {
                i += 2;
                if (i < pattern.length && pattern[i] == '/')
                {
                    buf.write('(?:.*/)?');
                    i++;
                }
                else
                {
                    buf.write('.*');
                }

                continue;
            }

            if (c == '*')
            {
                buf.write('[^/]*');
                i++;
                continue;
            }

            if (c == '?')
            {
                buf.write('[^/]');
                i++;
                continue;
            }

            if (r'.+()|^$\{}[]'.contains(c))
            {
                buf
                ..write(r'\')
                ..write(c);
                i++;
                continue;
            }

            buf.write(c);
            i++;
        }

        buf.write(r'$');
        return RegExp(buf.toString());
    }

    static List<String> _expandDirectory(String dir, List<RegExp> excludes)
    {
        final List<String> results = <String>[];
        // followLinks: false stops recursive descent at symbolic links / Windows
        // junctions, so a target directory containing a link to e.g. /etc or
        // C:\Windows doesn't pull arbitrary files into the format set.
        for (final FileSystemEntity entity in Directory(dir).listSync(recursive: true, followLinks: false))
        {
            if (entity is! File)
                continue;

            if (!entity.path.endsWith('.dart'))
                continue;

            final String normalised = _normalise(entity.path);
            if (!_isExcluded(normalised, excludes))
                results.add(normalised);
        }

        return results;
    }

    static List<String> _expandGlob(String pattern, List<RegExp> excludes)
    {
        final Glob glob = Glob(pattern);
        final List<String> results = <String>[];

        for (final FileSystemEntity entity in glob.listSync())
        {
            if (entity is! File)
                continue;

            if (!entity.path.endsWith('.dart'))
                continue;

            // The `glob` package follows links during expansion and we have no
            // knob to turn that off. Catching link-typed matches here covers
            // the case where a glob matches a symlinked file directly; descent
            // through a symlinked directory in the glob path is a known gap.
            if (FileSystemEntity.isLinkSync(entity.path))
                continue;

            final String normalised = _normalise(entity.path);
            if (!_isExcluded(normalised, excludes))
                results.add(normalised);
        }

        return results;
    }

    static bool _isExcluded(String path, List<RegExp> excludes)
    => excludes.any((RegExp r) => r.hasMatch(path));

    static bool _isGlob(String input)
    => input.contains('*') || input.contains('?') || input.contains('[') || input.contains('{');

    static String _normalise(String path)
    {
        final String forwardSlashed = path.replaceAll(r'\', '/');

        // Strip a leading `./` so paths discovered under input `.` are not
        // mis-matched by hidden-directory excludes like `**/.*/**`.
        if (forwardSlashed.startsWith('./'))
            return forwardSlashed.substring(2);

        return forwardSlashed;
    }
}
