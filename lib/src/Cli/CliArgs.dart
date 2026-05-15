import 'package:args/args.dart';

class CliArgs
{
    static const String CLASS_NAME = 'CliArgs';

    final String? configText;
    final String? errorMessage;
    final List<String> fileNames;
    final bool errorsAsJson;
    final bool isDryRun;
    final bool isEmpty;
    final bool isPipe;
    final bool isWebService;
    final bool logToConsole;
    final bool showHelp;
    final bool showVersion;
    final bool skipVersionCheck;

    const CliArgs({
        required this.configText,
        required this.errorMessage,
        required this.errorsAsJson,
        required this.fileNames,
        required this.isDryRun,
        required this.isEmpty,
        required this.isPipe,
        required this.isWebService,
        required this.logToConsole,
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

            final bool isPipe = results['pipe'] as bool;
            final bool isWebService = results['web'] as bool;

            if (isPipe && isWebService)
                return const CliArgs._error('Cannot specify both --pipe and --web.');

            return CliArgs(
                configText: results['config'] as String?,
                errorMessage: null,
                errorsAsJson: results['errors-as-json'] as bool,
                fileNames: List<String>.unmodifiable(results.rest),
                isDryRun: results['dry-run'] as bool,
                isEmpty: rawArgs.isEmpty,
                isPipe: isPipe,
                isWebService: isWebService,
                logToConsole: results['log-to-console'] as bool,
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
      : configText = null,
        errorMessage = message,
        errorsAsJson = false,
        fileNames = const <String>[],
        isDryRun = false,
        isEmpty = false,
        isPipe = false,
        isWebService = false,
        logToConsole = false,
        showHelp = false,
        showVersion = false,
        skipVersionCheck = false;

    static ArgParser buildParser()
    {
        final ArgParser parser = ArgParser();
        parser.addFlag('help', abbr: 'h', negatable: false, help: 'Print this help and exit.');
        parser.addFlag('version', abbr: 'V', negatable: false, help: 'Print version and exit.');
        parser.addOption('config', help: 'Configuration JSON.', valueHelp: 'JSON');
        parser.addFlag('dry-run', abbr: 'n', negatable: false, help: 'Format in memory only; no file writes.');
        parser.addFlag('errors-as-json', negatable: false, help: 'Write errors as JSON to stderr.');
        parser.addFlag('log-to-console', help: 'Log to console.');
        parser.addFlag('pipe', negatable: false, help: 'Format stdin (UTF-8) and write to stdout.');
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
