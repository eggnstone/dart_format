import 'LogTools.dart';

class InfoTools
{
    static void writeCopyrightToStdOut()
    => writelnToStdOut('dart_format (c) 2022-2024 Mark Eggenstein', preventLoggingToTempFile: true);

    static void writeUsageToStdOut()
    {
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

}
