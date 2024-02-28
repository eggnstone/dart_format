class Constants
{
    static const bool DEBUG = false;
    static const bool DEBUG_ALL = false;

    static const bool DEBUG_ANALYZER = (DEBUG && false) || DEBUG_ALL;
    static const bool DEBUG_DART_FORMAT_HANDLERS = (DEBUG && false) || DEBUG_ALL;
    static const bool DEBUG_FORMAT_STATE = (DEBUG && true) || DEBUG_ALL;
    static const bool DEBUG_FORMAT_TOOLS_IS_COMMA_TEXT = (DEBUG && false) || DEBUG_ALL;
    static const bool DEBUG_FORMAT_TOOLS_IS_EMPTY_OR_COMMENTS = (DEBUG && false) || DEBUG_ALL;
    static const bool DEBUG_FORMATTER = (DEBUG && false) || DEBUG_ALL;
    static const bool DEBUG_FORMATTER_DEFAULT = (DEBUG && true) || DEBUG_ALL;
    static const bool DEBUG_I_FORMATTER = (DEBUG && true) || DEBUG_ALL;
    static const bool DEBUG_I_FORMATTER_OFFSETS = (DEBUG && false) || DEBUG_ALL;
    static const bool DEBUG_STRING_TOOLS_REMOVE_LEADING_WHITESPACE = (DEBUG && false) || DEBUG_ALL;
    static const bool DEBUG_STRING_TOOLS_SPLIT_BLOCK_COMMENTS_AND_JOIN = (DEBUG && false) || DEBUG_ALL;
    static const bool DEBUG_TODOS = (DEBUG && false) || DEBUG_ALL;

    static const int HTTP_TOOLS_WAIT_BETWEEN_FLUSH_AND_CLOSE_IN_MILLISECONDS = 100;

    static const int MAX_DEBUG_LENGTH = 50;

    static const int PREFERRED_PORT = 7777;

    static const String REMOVE_TAG = 'DART_FORMAT_REMOVE';
    static const String REMOVE_START = '<$REMOVE_TAG>';
    static const String REMOVE_END = '</$REMOVE_TAG>';

    static const int WEB_SERVICE_HANDLER_WAIT_FOR_TERMINATE_IN_MILLISECONDS = 500;
}
