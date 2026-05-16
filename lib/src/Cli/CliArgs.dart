import 'dart:io';

import 'package:args/args.dart';

class CliArgs
{
    static const String CLASS_NAME = 'CliArgs';

    // Long options that used to exist and were removed in 2.0. Keep them in
    // the deny-list so a clear `Could not find an option ...` error fires,
    // instead of the silent forward-compat drop we now do for unknown longs.
    // Short options (e.g. `-n`) all fall through to the parser, which already
    // emits a clear error on unknown abbreviations.
    static const Set<String> REMOVED_LONG_OPTIONS = <String>{
        'dry-run',
        'pipe'
    };

    final String? configFile;
    final String? configText;
    final String? errorMessage;
    final int? port;
    final List<String> excludes;
    final List<String> fileNames;
    final bool checkVersion;
    final bool errorsAsJson;
    final bool isCheck;
    final bool isEmpty;
    final bool isWebService;
    final bool logToConsole;
    final bool showHelp;
    final bool showVersion;
    final bool skipVersionCheck;

    const CliArgs({
        required this.checkVersion,
        required this.configFile,
        required this.configText,
        required this.errorMessage,
        required this.errorsAsJson,
        required this.excludes,
        required this.fileNames,
        required this.isCheck,
        required this.isEmpty,
        required this.isWebService,
        required this.logToConsole,
        required this.port,
        required this.showHelp,
        required this.showVersion,
        required this.skipVersionCheck
    });

    factory CliArgs.parse(List<String> rawArgs)
    {
        final ArgParser parser = buildParser();

        try
        {
            final ArgResults results = parser.parse(_stripUnknownLongOptions(_normalize(rawArgs), parser));

            final String? portRaw = results['port'] as String?;
            final int? port = portRaw == null ? null : int.tryParse(portRaw);
            if (portRaw != null && port == null)
                return CliArgs._error('--port expects an integer, got "$portRaw".');

            final String? configText = results['config'] as String?;
            final String? configFile = results['config-file'] as String?;
            if (configText != null && configFile != null)
                return const CliArgs._error('Cannot specify both --config and --config-file.');

            return CliArgs(
                checkVersion: results['check-version'] as bool,
                configFile: configFile,
                configText: configText,
                errorMessage: null,
                errorsAsJson: results['errors-as-json'] as bool,
                excludes: List<String>.unmodifiable(results.multiOption('exclude')),
                fileNames: List<String>.unmodifiable(results.rest),
                isCheck: results['check'] as bool,
                isEmpty: rawArgs.isEmpty,
                isWebService: results['web'] as bool,
                logToConsole: results['log-to-console'] as bool,
                port: port,
                showHelp: results['help'] as bool,
                showVersion: results['version'] as bool,
                skipVersionCheck: results['skip-version-check'] as bool
            );
        }
        on ArgParserException catch (e)
        {
            return CliArgs._error(e.message);
        }
    }

    const CliArgs._error(String message)
      : checkVersion = false,
        configFile = null,
        configText = null,
        errorMessage = message,
        errorsAsJson = false,
        excludes = const <String>[],
        fileNames = const <String>[],
        isCheck = false,
        isEmpty = false,
        isWebService = false,
        logToConsole = false,
        port = null,
        showHelp = false,
        showVersion = false,
        skipVersionCheck = false;

    static ArgParser buildParser()
    {
        final ArgParser parser = ArgParser();
        parser.addFlag('help', abbr: 'h', negatable: false, help: 'Print this help and exit.');
        parser.addFlag('version', abbr: 'V', negatable: false, help: 'Print version and exit.');
        parser.addFlag('check', abbr: 'c', negatable: false, help: 'No writes; exit non-zero if any file would change. For CI.');
        parser.addFlag('check-version', negatable: false, help: 'Check pub.dev for a newer dart_format release on start-up.');
        parser.addOption('config', help: 'Configuration JSON (mutually exclusive with --config-file).', valueHelp: 'JSON');
        parser.addOption('config-file', help: 'Path to a JSON configuration file (mutually exclusive with --config).', valueHelp: 'PATH');
        parser.addFlag('errors-as-json', negatable: false, help: 'Write errors as JSON to stderr.');
        parser.addMultiOption('exclude', abbr: 'x', help: 'Exclude files matching this glob (repeatable).', valueHelp: 'GLOB');
        parser.addFlag('log-to-console', help: 'Log to console.');
        parser.addOption('port', help: 'Port for web service mode (default: 7777, fallback random).', valueHelp: 'N');
        parser.addFlag('skip-version-check', negatable: false, help: 'Skip version check on start-up.');
        parser.addFlag('web', aliases: <String>['webservice'], negatable: false, help: 'Start in web service mode.');
        return parser;
    }

    // Forward-compat: silently drops long options the parser hasn't been told
    // about, so a newer plugin can pass a flag this binary doesn't know yet
    // without the whole service failing to start. Removed options (see the
    // deny-lists at the top of the class) and unknown short forms still fall
    // through to the parser, which emits a real error — the goal is to
    // tolerate *future* flags, not to swallow typos in known short forms or
    // explicitly-removed options.
    static List<String> _stripUnknownLongOptions(List<String> args, ArgParser parser)
    {
        final Set<String> knownNames = <String>{};
        for (final MapEntry<String, Option> entry in parser.options.entries)
        {
            final String name = entry.key;
            final Option option = entry.value;
            knownNames.add(name);
            if (option.negatable ?? false)
                knownNames.add('no-$name');
            for (final String alias in option.aliases)
            {
                knownNames.add(alias);
                if (option.negatable ?? false)
                    knownNames.add('no-$alias');
            }
        }

        final List<String> result = <String>[];
        for (final String arg in args)
        {
            if (!arg.startsWith('--'))
            {
                result.add(arg);
                continue;
            }

            String name = arg.substring(2);
            final int eq = name.indexOf('=');
            if (eq >= 0)
                name = name.substring(0, eq);

            if (knownNames.contains(name) || REMOVED_LONG_OPTIONS.contains(name))
            {
                result.add(arg);
                continue;
            }

            stderr.writeln('Warning: ignoring unknown option: $arg');
        }

        return result;
    }

    // Rewrites `--log-to-console=true|false` (and `--log-to-temp-file=true|false`,
    // historically accepted) into the flag form that ArgParser understands.
    // Without this, `=value` syntax silently turns logging *on* regardless of
    // the value.
    static List<String> _normalize(List<String> rawArgs)
    {
        const Map<String, String> trueAliases = <String, String>
        {
            '--log-to-console=true': '--log-to-console',
            '--log-to-temp-file=true': '--log-to-temp-file'
        };

        const Map<String, String> falseAliases = <String, String>
        {
            '--log-to-console=false': '--no-log-to-console',
            '--log-to-temp-file=false': '--no-log-to-temp-file'
        };

        return rawArgs
            .map((String arg) => trueAliases[arg] ?? falseAliases[arg] ?? arg)
            .where((String arg) => arg != '--log-to-temp-file' && arg != '--no-log-to-temp-file')
            .toList();
    }
}
