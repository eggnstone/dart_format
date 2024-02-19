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
    static bool logInternals = true;
    static bool? logToConsole;
    static bool? logToTempFile;

    static final DateFormat _dateTimeFormatter = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    static RandomAccessFile? _logFile;

    static void logInternal(String message)
    {
        if (logInternals)
            logDebug(message);
    }

    static void logInternalInfo(String message)
    {
        if (logInternals)
            logInfo(message);
    }

    static void logInternalWarning(String message)
    {
        if (logInternals)
            logWarning(message);
    }

    static void logInternalError(String message)
    {
        if (logInternals)
            logError(message);
    }

    static void logDebug(String message, {bool preventLoggingToConsole = false})
    {
        if ((logToConsole ?? false) && !preventLoggingToConsole)
            eggnstone_dart.logDebug(message);

        if (logToTempFile ?? false)
            _logToTempFile('Debug:  $message');
    }

    static void logInfo(String message)
    {
        if (logToConsole ?? false)
            eggnstone_dart.logInfo(message);

        if (logToTempFile ?? false)
            _logToTempFile('Info:   $message');
    }

    static void logWarning(String message)
    {
        if (logToConsole ?? false)
            eggnstone_dart.logWarning(message);

        if (logToTempFile ?? false)
            _logToTempFile('Warn:   $message');
    }

    static void logError(String message)
    {
        if (logToConsole ?? false)
            eggnstone_dart.logError(message);

        if (logToTempFile ?? false)
            _logToTempFile('Error:  $message');
    }

    // TODO: move to eggnstone_dart
    static void logErrorObject(String source, Object error, StackTrace stackTrace)
    => logError('In $source\n$error\n$stackTrace');

    static void _logToTempFile(String s)
    {
        if (_logFile == null)
            if (!_createLogFile())
                return;

        //s = MemoryInfo ''+s;

        //eggnstone_dart.logDebug('## 1');
        _logFile!.writeStringSync('${_dateTimeFormatter.format(DateTime.now())} $s\n');
        //eggnstone_dart.logDebug('## 2');
        _logFile!.flushSync();
        //eggnstone_dart.logDebug('## 3');
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
            if (logToTempFile ?? false)
                _logToTempFile('Failed to write to stdout: $e');
        }

        if ((logToTempFile ?? false) && !preventLoggingToTempFile)
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
            if (logToTempFile ?? false)
                _logToTempFile('Failed to write to stdout: $e');
        }

        if ((logToTempFile ?? false) && !preventLoggingToTempFile)
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
            if (logToTempFile ?? false)
                _logToTempFile('Failed to write to stderr: $e');
        }

        if (logToTempFile ?? false)
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
