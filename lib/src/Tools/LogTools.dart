import 'dart:io';

import 'package:eggnstone_dart/eggnstone_dart.dart' as eggnstone_dart;
import 'package:intl/intl.dart';

void logInternal(String message)
=> LogTools.logInternal(message);

void logInternalInfo(String message)
=> LogTools.logInternalInfo(message);

void logInternalWarning(String message)
=> LogTools.logInternalWarning(message);

void logInternalError(String message)
=> LogTools.logInternalError(message);

void logDebug(String message, {bool preventLoggingToConsole = false})
=> LogTools.logDebug(message, preventLoggingToConsole: preventLoggingToConsole);

void logInfo(String message)
=> LogTools.logInfo(message);

void logWarning(String message)
=> LogTools.logWarning(message);

void logError(String message)
=> LogTools.logError(message);

void logErrorObject(String source, Object error, StackTrace stackTrace)
=> LogTools.logErrorObject(source, error, stackTrace);

void writeToStdOut(String s, {bool preventLoggingToTempFile = false})
=> LogTools.writeToStdOut(s, preventLoggingToTempFile: preventLoggingToTempFile);

void writelnToStdOut(String s, {bool preventLoggingToTempFile = false})
=> LogTools.writelnToStdOut(s, preventLoggingToTempFile: preventLoggingToTempFile);

void writelnToStdErr(String s)
=> LogTools.writelnToStdErr(s);

class LogTools
{
    static bool logInternals = true;//false;
    static bool? logToConsole;
    static bool? logToTempFile;

    static final DateFormat _dateTimeFormatter = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    static RandomAccessFile? _logFile;

    static void logInternal(String message)
    {
        if (logInternals)
            eggnstone_dart.logDebug(message);
    }

    static void logInternalInfo(String message)
    {
        if (logInternals)
            eggnstone_dart.logInfo(message);
    }

    static void logInternalWarning(String message)
    {
        if (logInternals)
            eggnstone_dart.logWarning(message);
    }

    static void logInternalError(String message)
    {
        if (logInternals)
            eggnstone_dart.logError(message);
    }

    static void logDebug(String message, {bool preventLoggingToConsole = false})
    {
        if (logToConsole! && !preventLoggingToConsole)
            eggnstone_dart.logDebug(message);

        if (logToTempFile!)
            _logToTempFile('Debug:  $message');
    }

    static void logInfo(String message)
    {
        if (logToConsole!)
            eggnstone_dart.logInfo(message);

        if (logToTempFile!)
            _logToTempFile('Info:   $message');
    }

    static void logWarning(String message)
    {
        if (logToConsole!)
            eggnstone_dart.logWarning(message);

        if (logToTempFile!)
            _logToTempFile('Warn:   $message');
    }

    static void logError(String message)
    {
        if (logToConsole!)
            eggnstone_dart.logError(message);

        if (logToTempFile!)
            _logToTempFile('Error:  $message');
    }

    static void logErrorObject(String source, Object error, StackTrace stackTrace)
    => logError('In $source\n$error\n$stackTrace');

    static void _logToTempFile(String s)
    {
        if (_logFile == null)
            if (!_createLogFile())
                return;

        _logFile!.writeStringSync('${_dateTimeFormatter.format(DateTime.now())} $s\n');
        _logFile!.flushSync();
    }

    static void writeToStdOut(String s, {bool preventLoggingToTempFile = false})
    {
        try
        {
            stdout.write(s);
        }
        catch (e)
        {
            // Sometimes (e.g. when /quit is being called) we may encounter
            // "OS Error: The pipe is being closed., errno = 232"
            if (logToTempFile!)
                _logToTempFile('Failed to write to stdout: $e');
        }

        if (logToTempFile!)
            _logToTempFile('StdOut: $s');
    }

    static void writelnToStdOut(String s, {bool preventLoggingToTempFile = false})
    {
        try
        {
            stdout.writeln(s);
        }
        catch (e)
        {
            // Sometimes (e.g. when /quit is being called) we may encounter
            // "OS Error: The pipe is being closed., errno = 232"
            if (logToTempFile!)
                _logToTempFile('Failed to write to stdout: $e');
        }

        if (logToTempFile!)
            _logToTempFile('StdOut: $s');
    }

    static void writelnToStdErr(String s)
    {
        try
        {
            stderr.writeln(s);
        }
        catch (e)
        {
            // Sometimes (e.g. when /quit is being called) we may encounter
            // "OS Error: The pipe is being closed., errno = 232"
            if (logToTempFile!)
                _logToTempFile('Failed to write to stderr: $e');
        }

        if (logToTempFile!)
            _logToTempFile('StdErr: $s');
    }

    static bool _createLogFile()
    {
        String timestamp = DateTime.now().toIso8601String();
        timestamp = timestamp.replaceAll(':', '-');
        timestamp = timestamp.replaceAll('T', '_');
        timestamp = timestamp.substring(0, timestamp.lastIndexOf('.'));
        final String logFileName = '${Directory.systemTemp.path}/dart_format_${timestamp}_$pid.log';

        try
        {
            _logFile = File(logFileName).openSync(mode: FileMode.append);
            return true;
        }
        catch (e)
        {
            return false;
        }
    }
}
