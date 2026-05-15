import '../Constants/Generated/VersionConstants.dart';
import 'LogTools.dart';

class InfoTools
{
    static void writeCopyrightToStdOut()
    => writelnToStdOut('dart_format v${VersionConstants.VERSION} (c) 2022-2026 Mark Eggenstein', preventLoggingToTempFile: true);

    static void writeUsageToStdOut()
    {
        writelnToStdOut('Usage: dart_format [args] <file|dir|glob> [<file|dir|glob> ...]', preventLoggingToTempFile: true);
        writelnToStdOut('    Positional inputs may be files, directories (recursed into *.dart),', preventLoggingToTempFile: true);
        writelnToStdOut('    or glob patterns (e.g. "lib/**/*.dart").', preventLoggingToTempFile: true);
        writelnToStdOut('    Pass `-` (or pipe stdin with no positional args) to format stdin to stdout.', preventLoggingToTempFile: true);
        writelnToStdOut('    --check, -c                      No writes; exits non-zero if any file would change (for CI)', preventLoggingToTempFile: true);
        writelnToStdOut('    --config=<JSON>                  Specifies the configuration', preventLoggingToTempFile: true);
        writelnToStdOut('    --dry-run, -n                    Formats in memory only; reports would-format files; no filesystem writes', preventLoggingToTempFile: true);
        writelnToStdOut('    --errors-as-json                 Writes errors as JSON to stderr', preventLoggingToTempFile: true);
        writelnToStdOut('    --exclude=<GLOB>, -x <GLOB>      Excludes files matching the glob (repeatable)', preventLoggingToTempFile: true);
        writelnToStdOut('    --help, -h                       Prints this help and exits', preventLoggingToTempFile: true);
        writelnToStdOut('    --log-to-console[=true|false]    Logs to console', preventLoggingToTempFile: true);
        writelnToStdOut('    --skip-version-check             Skips version check on start-up', preventLoggingToTempFile: true);
        writelnToStdOut('    --version, -V                    Prints the version and exits', preventLoggingToTempFile: true);
        writelnToStdOut('    --web                            Starts in web service mode', preventLoggingToTempFile: true);
    }
}
