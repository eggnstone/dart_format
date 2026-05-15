/// Exit codes for the application. Black-style:
///   0 — success.
///   1 — failure: parse error, --check found unformatted files, missing path, or an explicit input that is not a .dart file.
///   2 — usage error from argument parsing.
class ExitCodes
{
    /// Success.
    static const int SUCCESS = 0;

    /// Failure: parse error, --check diff, missing path, non-.dart explicit path, web service crash, etc.
    static const int FAILURE = 1;

    /// Usage error from argument parsing (bad flag, missing input, etc.).
    static const int USAGE_ERROR = 2;
}
