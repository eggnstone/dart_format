class ExitCodes
{
    static const int SUCCESS = 0;
    static const int SUCCESS_AND_NEW_VERSION_AVAILABLE = -1;

    static const int ERROR = 9;

    static const int COMMAND_LINE__OTHER_ERROR = 10;
    static const int COMMAND_LINE__ARGS_IS_EMPTY = 11;
    static const int COMMAND_LINE__CANNOT_SPECIFY_BOTH_PIPE_AND_WEB_SERVICE = 12;
    static const int COMMAND_LINE__UNKNOWN_ARGUMENT = 13;
}
