import 'dart:async';
import 'dart:io';

import 'package:dart_format/src/Constants/ExitCodes.dart';
import 'package:dart_format/src/Exceptions/DartFormatException.dart';
import 'package:dart_format/src/Handlers/DefaultHandler.dart';
import 'package:dart_format/src/Handlers/PipeHandler.dart';
import 'package:dart_format/src/Handlers/WebServiceHandler.dart';
import 'package:dart_format/src/Tools/LogTools.dart';
import 'package:dart_format/src/Types/FailType.dart';

Future<void> main(List<String> args)
async
{
    LogTools.logToConsole = args.contains('--log-to-console') || args.contains('--log-to-console=true');
    LogTools.logToTempFile = true;//args.contains('--log-to-temp-file') || args.contains('--log-to-temp-file=true');

    logDebug('main START', preventLoggingToConsole: true);

    bool encounteredErrorInRunZonedGuarded = false;
    final int? exitCode = await runZonedGuarded<Future<int>>(()
        async
        {
            logDebug('main/runZonedGuarded START', preventLoggingToConsole: true);
            final int exitCode = await main1(args);
            logDebug('main/runZonedGuarded END', preventLoggingToConsole: true);
            return exitCode;
        }
        , (Object error, StackTrace stackTrace)
        {
            logErrorObject('main/runZonedGuarded', error, stackTrace);
            encounteredErrorInRunZonedGuarded = true;
        }
    );

    logDebug('main END (ExitCode=$exitCode, EncounteredErrorInRunZonedGuarded=$encounteredErrorInRunZonedGuarded)', preventLoggingToConsole: true);
    exit(exitCode ?? ExitCodes.ERROR);
}

Future<int> main1(List<String> args)
async
{
    int exitCode;

    try
    {
        exitCode = await main2(args);
    }
    on DartFormatException catch (e)
    {
        final String optionalLocation = e.line == null && e.column == null ? '' : ' at ${e.line}:${e.column}';
        writelnToStdErr('${e.type.name}$optionalLocation: ${e.message}');
        exitCode = ExitCodes.COMMAND_LINE__OTHER_ERROR;
    }
    catch (e)
    {
        writelnToStdErr('Error in dart_format: $e');
        exitCode = ExitCodes.COMMAND_LINE__OTHER_ERROR;
    }
    finally
    {
        await stdout.close();
        await stderr.close();
    }

    return exitCode;
}

Future<int> main2(List<String> args)
async
{
    if (args.isEmpty)
    {
        logDebug('No arguments given => Printing usage.');
        writeUsageToStdOut();
        return ExitCodes.COMMAND_LINE__ARGS_IS_EMPTY;
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
            configText = argLower.substring('--config='.length);
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
            logDebug('Unknown argument: $arg => Printing usage.');
            writeUsageToStdOut();
            writelnToStdOut('Unknown argument: $arg');
            return ExitCodes.COMMAND_LINE__UNKNOWN_ARGUMENT;
        }

        fileNames.add(arg);
    }

    if (isPipe && isWebService)
    {
        logDebug('Cannot specify both --pipe and --webservice => Printing usage.');
        writeUsageToStdOut();
        writelnToStdOut('Cannot specify both --pipe and --webservice');
        return ExitCodes.COMMAND_LINE__CANNOT_SPECIFY_BOTH_PIPE_AND_WEB_SERVICE;
    }

    /*if (!skipVersionCheck && !isPipe && !isWebService && !LogTools.logToConsole!)
    {
    skipVersionCheck = true;
    logDebug('Skipping version check because not in pipe or web service mode and not logging to console.');
    }*/

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

    writeCopyrightToStdOut();

    final DefaultHandler defaultHandler = DefaultHandler(
        configText: configText,
        fileNames: fileNames,
        isDryRun: isDryRun,
        skipVersionCheck: skipVersionCheck
    );
    return defaultHandler.run();
}

void writeCopyrightToStdOut({bool preventLoggingToTempFile = false})
=> writelnToStdOut('dart_format (c) 2022-2024 Mark Eggenstein', preventLoggingToTempFile: preventLoggingToTempFile); // TODO: version

void writeUsageToStdOut()
{
    writeCopyrightToStdOut(preventLoggingToTempFile: true);
    writelnToStdOut('Usage: dart_format [args]', preventLoggingToTempFile: true);
    writelnToStdOut('    <dart file> [<dart file> ...]    Formats the specified dart file(s)', preventLoggingToTempFile: true);
    writelnToStdOut('    --config=<config JSON>           Specifies the configuration', preventLoggingToTempFile: true);
    writelnToStdOut('    --dry-run, -dr                   Writes output to "<original filename>.formatted.dart"', preventLoggingToTempFile: true);
    writelnToStdOut('    --errors-as-json                 Writes errors as JSON to stderr', preventLoggingToTempFile: true);
    writelnToStdOut('    --log-to-console                 Logs to console', preventLoggingToTempFile: true);
    //writelnToStdOut('    --log-to-temp-file               Logs to a temp file ("dart_format_<date>_<time>_<pid>.log" in the system temp directory)', preventLoggingToTempFile: true);
    writelnToStdOut('    --pipe                           Formats stdin and writes to stdout', preventLoggingToTempFile: true);
    writelnToStdOut('    --skip-version-check             Skips version check on start-up', preventLoggingToTempFile: true);
    writelnToStdOut('    --web[service]                   Starts in web service mode', preventLoggingToTempFile: true);
}
