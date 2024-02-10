import '../Constants/Constants.dart';
import '../Exceptions/DartFormatException.dart';
import 'LogTools.dart';
import 'StringTools.dart';

class FormatTools
{
    static bool isPeriodText(String s)
    => s == '.';

    static bool isCommaText(String s)
    {
        const String methodName = 'FormatTools.isCommaText';
        _log('# $methodName(${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)})');

        if (s.trim() == ',')
        {
            _log('  Simple comma found: ${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)}');
            return true;
        }

        final int commaPos = s.indexOf(',');
        if (commaPos == -1)
        {
            _log('  No comma found: ${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)}');
            return false;
        }

        final String beforeComma = s.substring(0, commaPos);
        if (!isEmptyOrComments(beforeComma))
        {
            _log('  beforeComma is not empty or comments: ${StringTools.toDisplayString(beforeComma, Constants.MAX_DEBUG_LENGTH)}');
            return false;
        }

        final String afterComma = s.substring(commaPos + 1);
        if (!isEmptyOrComments(afterComma))
        {
            _log('  afterComma is not empty or comments: ${StringTools.toDisplayString(afterComma, Constants.MAX_DEBUG_LENGTH)}');
            return false;
        }

        _log('  Comma surrounded by comments found: ${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)}');
        return true;
    }

    static bool isEmptyOrComments(String s)
    {
        const String methodName = 'FormatTools.isEmptyOrComments';
        _log('# $methodName(${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)})');

        bool isInEndOfLineComment = false;
        int blockCommentDepth = 0;

        for (int i = 0; i < s.length; i++)
        {
            final String char = s[i];
            final String? nextChar = i < s.length - 1 ? s[i + 1] : null;
            _log('  char: ${StringTools.toDisplayString(char)} nextChar: ${StringTools.toDisplayString(nextChar)}');

            if (isInEndOfLineComment)
            {
                if (char == '\n')
                {
                    isInEndOfLineComment = false;
                    _log('  Now isInEndOfLineComment=false');
                    continue;
                }

                continue;
            }

            if (char == '/' && nextChar == '*')
            {
                blockCommentDepth++;
                _log('  Now blockCommentDepth++: $blockCommentDepth');
                i++;
                continue;
            }

            if (char == '*' && nextChar == '/')
            {
                blockCommentDepth--;
                _log('  Now blockCommentDepth--: $blockCommentDepth');
                if (blockCommentDepth < 0)
                {
                    _logError('Block comment ended but blockCommentDepth < 0');
                    return false;
                }

                i++;
                continue;
            }

            if (blockCommentDepth > 0)
                continue;

            if (char == '/' && nextChar == '/')
            {
                isInEndOfLineComment = true;
                _log('  Now isInEndOfLineComment=true');
                i++;
                continue;
            }

            if (char == ' ' || char == '\t' || char == '\n')
                continue;

            _log('  Result: false');
            return false;
        }

        if (blockCommentDepth > 0)
        {
            _logError('Text ended but blockCommentDepth > 0');
            return false;
        }

        _log('  Result: true');
        return true;
    }

    static String removeIgnoreTagsCompletely(String s)
    {
        String result = s;
        while (result.contains(Constants.REMOVE_START))
        {
            final int start = result.indexOf(Constants.REMOVE_START);
            final int end = result.indexOf(Constants.REMOVE_END, start);
            if (end == -1)
                throw DartFormatException.error('Internal error: Missing ${Constants.REMOVE_END} in result.');

            result = result.substring(0, start) + result.substring(end + Constants.REMOVE_END.length);
        }

        return result;
    }

    static String removeIgnoreTagsOnly(String s)
    {
        String result = s;
        while (result.contains(Constants.REMOVE_START))
        {
            final int start = result.indexOf(Constants.REMOVE_START);
            final int end = result.indexOf(Constants.REMOVE_END, start);
            if (end == -1)
                throw DartFormatException.error('Internal error: Missing ${Constants.REMOVE_END} in result.');

            result = result.substring(0, start)
            + result.substring(start + Constants.REMOVE_START.length, end)
            + result.substring(end + Constants.REMOVE_END.length);
        }

        return result;
    }

    static void _log(String s)
    {
        if (Constants.DEBUG_FORMAT_TOOLS)
            logInternal(s);
    }

    static void _logError(String s)
    {
        if (Constants.DEBUG_FORMAT_TOOLS)
            logInternalError(s);
    }
}
