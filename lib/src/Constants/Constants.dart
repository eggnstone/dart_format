// ignore_for_file: no_literal_bool_comparisons

class Constants
{
    static const bool DEBUG = false;
    static const bool DEBUG_ALL = false;

    static const bool DEBUG_COMMENT_TOOLS = (DEBUG && false) || DEBUG_ALL;
    static const bool DEBUG_DART_FORMAT_HANDLERS = (DEBUG && false) || DEBUG_ALL;
    static const bool DEBUG_FORMAT_STATE = (DEBUG && false) || DEBUG_ALL;
    static const bool DEBUG_FORMAT_STATE_SPACING = (DEBUG && false) || DEBUG_ALL;
    static const bool DEBUG_FORMAT_TOOLS = (DEBUG && false) || DEBUG_ALL;
    static const bool DEBUG_FORMATTER = (DEBUG && false) || DEBUG_ALL;
    static const bool DEBUG_FORMATTER_DEFAULT = (DEBUG && false) || DEBUG_ALL;
    static const bool DEBUG_I_FORMATTER = (DEBUG && false) || DEBUG_ALL;
    static const bool DEBUG_I_FORMATTER_OFFSETS = (DEBUG && false) || DEBUG_ALL;
    static const bool DEBUG_I_FORMATTER_TIME = (DEBUG && false) || DEBUG_ALL;
    static const bool DEBUG_LEADING_WHITESPACE_REMOVER = (DEBUG && false) || DEBUG_ALL;
    static const bool DEBUG_STRING_TOOLS = (DEBUG && false) || DEBUG_ALL;
    static const bool DEBUG_TEXT_EXTRACTOR = (DEBUG && false) || DEBUG_ALL;
    static const bool DEBUG_TEXT_SEPARATOR = (DEBUG && false) || DEBUG_ALL;
    static const bool DEBUG_TODOS = (DEBUG && false) || DEBUG_ALL;

    static const int HTTP_TOOLS_WAIT_BETWEEN_FLUSH_AND_CLOSE_IN_MILLISECONDS = 100;

    static const int LOG_FILE_RETENTION_IN_DAYS = 30;

    static const int MAX_CONFIG_FILE_SIZE_IN_BYTES = 1 * 1024 * 1024;
    static const int MAX_DEBUG_LENGTH = 50;
    static const int MAX_FORMAT_TIME_IN_SECONDS = DEBUG ? 10 : 50;
    static const int MAX_FORMAT_TIME_IN_SECONDS_FOR_TESTS = 1;
    static const int MAX_LOG_FILE_SIZE_IN_BYTES = 10 * 1024 * 1024;
    static const int MAX_REQUEST_BODY_SIZE_IN_BYTES = 4 * 1024 * 1024;
    static const int MAX_REQUEST_HANDLING_TIME_IN_SECONDS = 60;

    static const String REMOVE_TAG = 'DART_FORMAT_REMOVE';
    static const String REMOVE_START = '<$REMOVE_TAG>';
    static const String REMOVE_END = '</$REMOVE_TAG>';

    static const String INDENT_TAG = 'DART_FORMAT_INDENT';
    static const String INDENT_START = '<$INDENT_TAG=';
    static const String INDENT_END = '/>';

    static const int WEB_SERVICE_HANDLER_WAIT_FOR_TERMINATE_IN_MILLISECONDS = 500;
}
