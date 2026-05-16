import 'dart:async';
import 'dart:io';

import 'package:dart_format/src/Cli/CliArgs.dart';
import 'package:dart_format/src/Constants/ExitCodes.dart';
import 'package:dart_format/src/Enums/FailType.dart';
import 'package:dart_format/src/Exceptions/DartFormatException.dart';
import 'package:dart_format/src/Handlers/DefaultHandler.dart';
import 'package:dart_format/src/Handlers/PipeHandler.dart';
import 'package:dart_format/src/Handlers/WebServiceHandler.dart';
import 'package:dart_format/src/Tools/FileResolver.dart';
import 'package:dart_format/src/Tools/InfoTools.dart';
import 'package:dart_format/src/Tools/LogTools.dart';

Future<void> main(List<String> args)
async
{
    final CliArgs cliArgs = CliArgs.parse(args);
    LogTools.logToConsole = cliArgs.logToConsole;

    // Step 1 of staged opt-in: web mode still force-logs to the temp file
    // because IDE plugins surface that path in their bug-report flow. CLI
    // modes honour the flag so a CI run of `dart_format --check` doesn't
    // litter /tmp on every invocation. Step 2 will flip web mode to honour
    // the flag too, once the plugins ship `--log-to-temp-file=true`.
    LogTools.logToTempFile = cliArgs.isWebService ? true : cliArgs.logToTempFile;

    logDebug('main START', preventLoggingToConsole: true);

    bool encounteredErrorInRunZonedGuarded = false;
    final int? exitCode = await runZonedGuarded<Future<int>>(()
        async
        {
            logDebug('main/runZonedGuarded START', preventLoggingToConsole: true);
            final int exitCode = await mainNoThrow(cliArgs);
            logDebug('main/runZonedGuarded END', preventLoggingToConsole: true);
            return exitCode;
        },
        (Object error, StackTrace stackTrace)
        {
            logErrorObject('main/runZonedGuarded', error, stackTrace);
            encounteredErrorInRunZonedGuarded = true;
        }
    );

    logDebug('main END (ExitCode=$exitCode, EncounteredErrorInRunZonedGuarded=$encounteredErrorInRunZonedGuarded)', preventLoggingToConsole: true);
    exit(exitCode ?? ExitCodes.FAILURE);
}

Future<int> mainNoThrow(CliArgs cliArgs)
async
{
    int exitCode;

    try
    {
        exitCode = await mainOrThrow(cliArgs);
    }
    on DartFormatException catch (e)
    {
        final String optionalLocation = e.line == null && e.column == null ? '' : ' at ${e.line}:${e.column}';
        writelnToStdErr('${e.type.displayName}$optionalLocation: ${e.message}');
        exitCode = ExitCodes.FAILURE;
    }
    catch (e)
    {
        writelnToStdErr('Error in dart_format: $e');
        exitCode = ExitCodes.FAILURE;
    }
    finally
    {
        await stdout.close();
        await stderr.close();
    }

    return exitCode;
}

Future<int> mainOrThrow(CliArgs cliArgs)
async
{
    if (cliArgs.showHelp)
    {
        InfoTools.writeCopyrightToStdOut();
        InfoTools.writeUsageToStdOut();
        return ExitCodes.SUCCESS;
    }

    if (cliArgs.showVersion)
    {
        InfoTools.writeCopyrightToStdOut();
        return ExitCodes.SUCCESS;
    }

    if (cliArgs.errorMessage != null)
    {
        InfoTools.writeCopyrightToStdOut();
        InfoTools.writeUsageToStdOut();
        writelnToStdErr(cliArgs.errorMessage!);
        return ExitCodes.USAGE_ERROR;
    }

    final String? configText = _readConfig(cliArgs);

    if (cliArgs.isWebService)
    {
        // Web mode keeps the historical "auto-check on start-up" until the
        // IntelliJ and VS Code plugins have shipped support for --check-version
        // (Step 2 of the staged opt-in). --skip-version-check still suppresses
        // it; --check-version is silently accepted but is a no-op here today.
        final WebServiceHandler webServiceHandler = WebServiceHandler(
            port: cliArgs.port,
            skipVersionCheck: cliArgs.skipVersionCheck
        );
        return webServiceHandler.run();
    }

    // CLI modes (file / pipe): the version check is opt-in. The previous
    // default was opt-out (auto-check unless --skip-version-check); that meant
    // every `dart_format --check` in CI did a DNS + HTTPS round-trip for no
    // user-visible benefit. --skip-version-check still works for back-compat.
    final bool skipVersionCheck = cliArgs.skipVersionCheck || !cliArgs.checkVersion;

    final bool isStdinMode = cliArgs.fileNames.contains('-')
        || (cliArgs.fileNames.isEmpty && !stdin.hasTerminal);

    if (isStdinMode)
    {
        final PipeHandler pipeHandler = PipeHandler(
            configText: configText,
            errorsAsJson: cliArgs.errorsAsJson,
            skipVersionCheck: skipVersionCheck
        );
        return pipeHandler.run();
    }

    if (cliArgs.fileNames.isEmpty)
    {
        InfoTools.writeCopyrightToStdOut();
        logDebug('No inputs given => Printing usage.');
        InfoTools.writeUsageToStdOut();
        return ExitCodes.USAGE_ERROR;
    }

    final List<String> resolvedFileNames = FileResolver.resolve(
        inputs: cliArgs.fileNames,
        userExcludes: cliArgs.excludes
    );

    final DefaultHandler defaultHandler = DefaultHandler(
        configText: configText,
        fileNames: resolvedFileNames,
        isCheck: cliArgs.isCheck,
        skipVersionCheck: skipVersionCheck
    );
    return defaultHandler.run();
}

String? _readConfig(CliArgs cliArgs)
{
    if (cliArgs.configFile == null)
        return cliArgs.configText;

    final File file = File(cliArgs.configFile!);
    if (!file.existsSync())
        throw DartFormatException.error('--config-file not found: ${cliArgs.configFile}');

    try
    {
        return file.readAsStringSync();
    }
    on FileSystemException catch (e)
    {
        throw DartFormatException.error('Failed to read --config-file ${cliArgs.configFile}: ${e.message}');
    }
}
