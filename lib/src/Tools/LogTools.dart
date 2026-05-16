import 'dart:io';

import 'package:eggnstone_dart/eggnstone_dart.dart' as eggnstone_dart;
import 'package:intl/intl.dart';

import '../Constants/Constants.dart';

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
    static String? _logFilePath;
    static int _logFileSizeBytes = 0;

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

        final String line = '${_dateTimeFormatter.format(DateTime.now())} $s\n';
        _logFile!.writeStringSync(line);
        _logFile!.flushSync();
        _logFileSizeBytes += line.length;

        if (_logFileSizeBytes > Constants.MAX_LOG_FILE_SIZE_IN_BYTES)
            _rotateLogFile();
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
        _cleanupOldLogFiles();

        String timestamp = DateTime.now().toIso8601String();
        timestamp = timestamp.replaceAll(':', '-');
        timestamp = timestamp.replaceAll('T', '_');
        timestamp = timestamp.substring(0, timestamp.lastIndexOf('.'));
        final String logFileName = '${Directory.systemTemp.path}/dart_format_${timestamp}_$pid.log';

        try
        {
            _logFile = File(logFileName).openSync(mode: FileMode.append);
            _logFilePath = logFileName;
            _logFileSizeBytes = File(logFileName).lengthSync();
            return true;
        }
        catch (e)
        {
            return false;
        }
    }

    // Run once per session (called from _createLogFile on the first log write).
    // Drops any `dart_format_*.log` / `.log.old` file in systemTemp that hasn't
    // been touched in LOG_FILE_RETENTION_IN_DAYS days. Best-effort: per-file
    // failures (e.g. locked by a concurrent dart_format process) are swallowed.
    static void _cleanupOldLogFiles()
    {
        try
        {
            final DateTime cutoff = DateTime.now().subtract(const Duration(days: Constants.LOG_FILE_RETENTION_IN_DAYS));
            final String pidSuffix = '_$pid.log';

            for (final FileSystemEntity entity in Directory.systemTemp.listSync(followLinks: false))
            {
                if (entity is! File)
                    continue;

                final String name = entity.uri.pathSegments.last;
                if (!name.startsWith('dart_format_'))
                    continue;

                if (!name.endsWith('.log') && !name.endsWith('.log.old'))
                    continue;

                // Never delete the current process's own files.
                if (name.contains(pidSuffix))
                    continue;

                try
                {
                    if (entity.lastModifiedSync().isBefore(cutoff))
                        entity.deleteSync();
                }
                on FileSystemException
                {
                    // File locked / deleted concurrently — skip.
                }
            }
        }
        on FileSystemException
        {
            // systemTemp not listable — skip cleanup, not fatal.
        }
    }

    // Caps each session's log at 2 * MAX_LOG_FILE_SIZE_IN_BYTES: the current
    // file plus one rotated `.old` backup. The current path stays the same so
    // any caller (e.g. IDE plugin surfacing the log to the user) still finds
    // the recent entries; older entries are in `<path>.old`.
    static void _rotateLogFile()
    {
        final String? currentPath = _logFilePath;
        if (_logFile == null || currentPath == null)
            return;

        try
        {
            _logFile!.closeSync();
        }
        on FileSystemException
        {
            // best effort
        }
        _logFile = null;

        try
        {
            final File oldFile = File('$currentPath.old');
            if (oldFile.existsSync())
                oldFile.deleteSync();
            File(currentPath).renameSync('$currentPath.old');
        }
        on FileSystemException
        {
            // best effort — proceed to open a fresh handle at currentPath
        }

        try
        {
            _logFile = File(currentPath).openSync(mode: FileMode.append);
            _logFileSizeBytes = 0;
        }
        on FileSystemException
        {
            _logFile = null;
        }
    }
}
