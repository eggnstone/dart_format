import 'dart:async';
import 'dart:io';

import 'package:dart_format/src/Constants/ExitCodes.dart';
import 'package:dart_format/src/Exceptions/DartFormatException.dart';
import 'package:dart_format/src/Handlers/DefaultHandler.dart';
import 'package:dart_format/src/Handlers/PipeHandler.dart';
import 'package:dart_format/src/Handlers/WebServiceHandler.dart';
import 'package:dart_format/src/Tools/InfoTools.dart';
import 'package:dart_format/src/Tools/LogTools.dart';
import 'package:dart_format/src/Types/FailType.dart';

Future<void> main(List<String> args)
async
{
    LogTools.logToConsole = args.contains('--log-to-console') || args.contains('--log-to-console=true');

    // Mandatory for the beta phase. Optional afterwards.
    LogTools.logToTempFile = true;//args.contains('--log-to-temp-file') || args.contains('--log-to-temp-file=true');

    logDebug('main START', preventLoggingToConsole: true);

    bool encounteredErrorInRunZonedGuarded = false;
    final int? exitCode = await runZonedGuarded<Future<int>>(()
        async
        {
            logDebug('main/runZonedGuarded START', preventLoggingToConsole: true);
            final int exitCode = await mainNoThrow(args);
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

Future<int> mainNoThrow(List<String> args)
async
{
    int exitCode;

    try
    {
        exitCode = await mainOrThrow(args);
    }
    on DartFormatException catch (e)
    {
        final String optionalLocation = e.line == null && e.column == null ? '' : ' at ${e.line}:${e.column}';
        writelnToStdErr('${e.type.name}$optionalLocation: ${e.message}');
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

Future<int> mainOrThrow(List<String> args)
async
{
    if (args.isEmpty)
    {
        InfoTools.writeCopyrightToStdOut();
        logDebug('No arguments given => Printing usage.');
        InfoTools.writeUsageToStdOut();
        return ExitCodes.ERROR;
    }

    final List<String> fileNames = <String>[];
    String? configText;
    bool errorsAsJson = false;
    bool isDryRun = false;
    bool isPipe = false;
    bool isWebService = false;
    bool skipVersionCheck = false;

    for (final String arg in args)
    {
        final String argLower = arg.toLowerCase();

        if (argLower == '--skip-version-check')
        {
            skipVersionCheck = true;
            continue;
        }

        if (argLower.startsWith('--config='))
        {
            configText = arg.substring('--config='.length);
            continue;
        }

        if (argLower == '--dry-run' || argLower == '-dr')
        {
            isDryRun = true;
            continue;
        }

        if (argLower == '--errors-as-json')
        {
            errorsAsJson = true;
            continue;
        }

        if (argLower == '--pipe')
        {
            isPipe = true;
            continue;
        }

        if (argLower == '--web' || argLower == '--webservice')
        {
            isWebService = true;
            continue;
        }

        if (argLower.startsWith('--log-to-console') || argLower.startsWith('--log-to-temp-file'))
            continue;

        if (argLower.startsWith('-'))
        {
            InfoTools.writeCopyrightToStdOut();
            logDebug('Unknown argument: $arg => Printing usage.');
            InfoTools.writeUsageToStdOut();
            writelnToStdOut('Unknown argument: $arg');
            return ExitCodes.ERROR;
        }

        fileNames.add(arg);
    }

    if (isPipe && isWebService)
    {
        InfoTools.writeCopyrightToStdOut();
        logDebug('Cannot specify both --pipe and --webservice => Printing usage.');
        InfoTools.writeUsageToStdOut();
        writelnToStdOut('Cannot specify both --pipe and --webservice');
        return ExitCodes.ERROR;
    }

    if (isPipe)
    {
        final PipeHandler pipeHandler = PipeHandler(
            configText: configText,
            errorsAsJson: errorsAsJson,
            skipVersionCheck: skipVersionCheck
        );
        return pipeHandler.run();
    }

    if (isWebService)
    {
        final WebServiceHandler webServiceHandler = WebServiceHandler(skipVersionCheck: skipVersionCheck);
        return webServiceHandler.run();
    }

    final DefaultHandler defaultHandler = DefaultHandler(
        configText: configText,
        fileNames: fileNames,
        isDryRun: isDryRun,
        skipVersionCheck: skipVersionCheck
    );
    return defaultHandler.run();
}
