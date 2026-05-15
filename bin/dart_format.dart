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

    // Mandatory for the beta phase. Optional afterwards.
    LogTools.logToTempFile = true;

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
    exit(exitCode ?? ExitCodes.ERROR);
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
        exitCode = ExitCodes.ERROR;
    }
    catch (e)
    {
        writelnToStdErr('Error in dart_format: $e');
        exitCode = ExitCodes.ERROR;
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
        return ExitCodes.ERROR;
    }

    if (cliArgs.isEmpty)
    {
        InfoTools.writeCopyrightToStdOut();
        logDebug('No arguments given => Printing usage.');
        InfoTools.writeUsageToStdOut();
        return ExitCodes.ERROR;
    }

    if (cliArgs.isPipe)
    {
        final PipeHandler pipeHandler = PipeHandler(
            configText: cliArgs.configText,
            errorsAsJson: cliArgs.errorsAsJson,
            skipVersionCheck: cliArgs.skipVersionCheck
        );
        return pipeHandler.run();
    }

    if (cliArgs.isWebService)
    {
        final WebServiceHandler webServiceHandler = WebServiceHandler(skipVersionCheck: cliArgs.skipVersionCheck);
        return webServiceHandler.run();
    }

    final List<String> resolvedFileNames = FileResolver.resolve(
        inputs: cliArgs.fileNames,
        userExcludes: cliArgs.excludes
    );

    final DefaultHandler defaultHandler = DefaultHandler(
        configText: cliArgs.configText,
        fileNames: resolvedFileNames,
        isDryRun: cliArgs.isDryRun,
        skipVersionCheck: cliArgs.skipVersionCheck
    );
    return defaultHandler.run();
}
