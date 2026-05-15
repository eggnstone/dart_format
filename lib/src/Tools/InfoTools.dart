import '../Constants/Generated/VersionConstants.dart';
import 'LogTools.dart';

class InfoTools
{
    static void writeCopyrightToStdOut()
    => writelnToStdOut('dart_format v${VersionConstants.VERSION} (c) 2022-2026 Mark Eggenstein', preventLoggingToTempFile: true);

    static void writeUsageToStdOut()
    {
        writelnToStdOut('Usage: dart_format [args]', preventLoggingToTempFile: true);
        writelnToStdOut('    <dart file> [<dart file> ...]    Formats the specified dart file(s)', preventLoggingToTempFile: true);
        writelnToStdOut('    --config=<JSON>                  Specifies the configuration', preventLoggingToTempFile: true);
        writelnToStdOut('    --dry-run, -n                    Formats in memory only; reports would-format files; no filesystem writes', preventLoggingToTempFile: true);
        writelnToStdOut('    --errors-as-json                 Writes errors as JSON to stderr', preventLoggingToTempFile: true);
        writelnToStdOut('    --help, -h                       Prints this help and exits', preventLoggingToTempFile: true);
        writelnToStdOut('    --log-to-console[=true|false]    Logs to console', preventLoggingToTempFile: true);
        writelnToStdOut('    --pipe                           Formats stdin (UTF-8) and writes to stdout', preventLoggingToTempFile: true);
        writelnToStdOut('    --skip-version-check             Skips version check on start-up', preventLoggingToTempFile: true);
        writelnToStdOut('    --version, -V                    Prints the version and exits', preventLoggingToTempFile: true);
        writelnToStdOut('    --web                            Starts in web service mode', preventLoggingToTempFile: true);
    }
}
