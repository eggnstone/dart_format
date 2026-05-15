import 'package:args/args.dart';

class CliArgs
{
    static const String CLASS_NAME = 'CliArgs';

    final String? configFile;
    final String? configText;
    final String? errorMessage;
    final int? port;
    final List<String> excludes;
    final List<String> fileNames;
    final bool errorsAsJson;
    final bool isCheck;
    final bool isDryRun;
    final bool isEmpty;
    final bool isWebService;
    final bool logToConsole;
    final bool showHelp;
    final bool showVersion;
    final bool skipVersionCheck;

    const CliArgs({
        required this.configFile,
        required this.configText,
        required this.errorMessage,
        required this.errorsAsJson,
        required this.excludes,
        required this.fileNames,
        required this.isCheck,
        required this.isDryRun,
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
            final ArgResults results = parser.parse(_normalize(rawArgs));

            final String? portRaw = results['port'] as String?;
            final int? port = portRaw == null ? null : int.tryParse(portRaw);
            if (portRaw != null && port == null)
                return CliArgs._error('--port expects an integer, got "$portRaw".');

            final String? configText = results['config'] as String?;
            final String? configFile = results['config-file'] as String?;
            if (configText != null && configFile != null)
                return const CliArgs._error('Cannot specify both --config and --config-file.');

            return CliArgs(
                configFile: configFile,
                configText: configText,
                errorMessage: null,
                errorsAsJson: results['errors-as-json'] as bool,
                excludes: List<String>.unmodifiable(results.multiOption('exclude')),
                fileNames: List<String>.unmodifiable(results.rest),
                isCheck: results['check'] as bool,
                isDryRun: results['dry-run'] as bool,
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
      : configFile = null,
        configText = null,
        errorMessage = message,
        errorsAsJson = false,
        excludes = const <String>[],
        fileNames = const <String>[],
        isCheck = false,
        isDryRun = false,
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
        parser.addOption('config', help: 'Configuration JSON (mutually exclusive with --config-file).', valueHelp: 'JSON');
        parser.addOption('config-file', help: 'Path to a JSON configuration file (mutually exclusive with --config).', valueHelp: 'PATH');
        parser.addFlag('dry-run', abbr: 'n', negatable: false, help: 'Format in memory only; no file writes.');
        parser.addFlag('errors-as-json', negatable: false, help: 'Write errors as JSON to stderr.');
        parser.addMultiOption('exclude', abbr: 'x', help: 'Exclude files matching this glob (repeatable).', valueHelp: 'GLOB');
        parser.addFlag('log-to-console', help: 'Log to console.');
        parser.addOption('port', help: 'Port for web service mode (default: 7777, fallback random).', valueHelp: 'N');
        parser.addFlag('skip-version-check', negatable: false, help: 'Skip version check on start-up.');
        parser.addFlag('web', aliases: <String>['webservice'], negatable: false, help: 'Start in web service mode.');
        return parser;
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
