class Constants
{
    static const bool DEBUG = true;
    static const bool DEBUG_ALL = true;

    static const bool DEBUG_DART_FORMAT_HANDLERS = (DEBUG && false) || DEBUG_ALL;
    static const bool DEBUG_FORMAT_STATE = (DEBUG && false) || DEBUG_ALL;
    static const bool DEBUG_FORMAT_TOOLS = (DEBUG && false) || DEBUG_ALL;
    static const bool DEBUG_FORMAT_VISITOR = (DEBUG && false) || DEBUG_ALL;
    static const bool DEBUG_FORMAT_VISITOR_UNIMPLEMENTED = (DEBUG && false) || DEBUG_ALL;
    static const bool DEBUG_FORMATTER = (DEBUG && false) || DEBUG_ALL;
    static const bool DEBUG_FORMATTER_DEFAULT = (DEBUG && false) || DEBUG_ALL;
    static const bool DEBUG_I_FORMATTER = (DEBUG && true) || DEBUG_ALL;
    static const bool DEBUG_INDENT_TOOLS = (DEBUG && false) || DEBUG_ALL;
    static const bool DEBUG_STRING_TOOLS = (DEBUG && false) || DEBUG_ALL;

    static const int MAX_DEBUG_LENGTH = 100;

    static const int PREFERRED_PORT = 7777;

    static const String REMOVE_TAG = 'DART_FORMAT_REMOVE';
    static const String REMOVE_START = '<$REMOVE_TAG>';
    static const String REMOVE_END = '</$REMOVE_TAG>';
}
