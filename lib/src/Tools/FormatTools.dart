// ignore_for_file: always_put_control_body_on_new_line

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
        if (Constants.DEBUG_FORMAT_TOOLS_IS_COMMA_TEXT) logInternal('# $methodName(${StringTools.toDisplayString(s)})');

        if (s.trim() == ',')
        {
            if (Constants.DEBUG_FORMAT_TOOLS_IS_COMMA_TEXT) logInternal('  Simple comma found: ${StringTools.toDisplayString(s)}');
            return true;
        }

        final int commaPos = s.indexOf(',');
        if (commaPos == -1)
        {
            if (Constants.DEBUG_FORMAT_TOOLS_IS_COMMA_TEXT) logInternal('  No comma found: ${StringTools.toDisplayString(s)}');
            return false;
        }

        final String beforeComma = s.substring(0, commaPos);
        if (!isEmptyOrComments(beforeComma))
        {
            if (Constants.DEBUG_FORMAT_TOOLS_IS_COMMA_TEXT) logInternal('  beforeComma is not empty or comments: ${StringTools.toDisplayString(beforeComma)}');
            return false;
        }

        final String afterComma = s.substring(commaPos + 1);
        if (!isEmptyOrComments(afterComma))
        {
            if (Constants.DEBUG_FORMAT_TOOLS_IS_COMMA_TEXT) logInternal('  afterComma is not empty or comments: ${StringTools.toDisplayString(afterComma)}');
            return false;
        }

        if (Constants.DEBUG_FORMAT_TOOLS_IS_COMMA_TEXT) logInternal('  Comma surrounded by comments found: ${StringTools.toDisplayString(s)}');
        return true;
    }

    // TODO: comma in comments
    static String? getMaxCommaText(String s)
    {
        const String methodName = 'FormatTools.getMaxCommaText';
        if (Constants.DEBUG_FORMAT_TOOLS_GET_MAX_COMMA_TEXT) logInternal('# $methodName(${StringTools.toDisplayString(s)})');

        final int commaPos = s.indexOf(',');
        if (commaPos == -1)
        {
            if (Constants.DEBUG_FORMAT_TOOLS_GET_MAX_COMMA_TEXT) logInternal('  No comma found: ${StringTools.toDisplayString(s)}');
            return null;
        }

        final String textBeforeComma = s.substring(0, commaPos);
        final String maxCommaText = '$textBeforeComma,';
        if (Constants.DEBUG_FORMAT_TOOLS_GET_MAX_COMMA_TEXT)
        {
            logInternal('  commaPos:        $commaPos');
            logInternal('  textBeforeComma: ${StringTools.toDisplayString(textBeforeComma)}');
            logInternal('  maxCommaText:    ${StringTools.toDisplayString(maxCommaText)}');
        }

        if (textBeforeComma.trim().isEmpty)
        {
            if (Constants.DEBUG_FORMAT_TOOLS_GET_MAX_COMMA_TEXT) logInternal('  textBeforeComma is empty: ${StringTools.toDisplayString(textBeforeComma)}');
            return maxCommaText;
        }

        if (isEmptyOrComments(textBeforeComma))
        {
            if (Constants.DEBUG_FORMAT_TOOLS_GET_MAX_COMMA_TEXT) logInternal('  textBeforeComma is empty or comments: ${StringTools.toDisplayString(textBeforeComma)}');
            return maxCommaText;
        }

        if (Constants.DEBUG_FORMAT_TOOLS_GET_MAX_COMMA_TEXT) logInternal('  textBeforeComma is neither empty nor comments: ${StringTools.toDisplayString(textBeforeComma)}');
        return null;
    }

    static bool isEmptyOrComments(String s)
    {
        const String methodName = 'FormatTools.isEmptyOrComments';
        if (Constants.DEBUG_FORMAT_TOOLS_IS_EMPTY_OR_COMMENTS) logInternal('# $methodName(${StringTools.toDisplayString(s)})');

        bool isInEndOfLineComment = false;
        int blockCommentDepth = 0;

        for (int i = 0; i < s.length; i++)
        {
            final String char = s[i];
            final String? nextChar = i < s.length - 1 ? s[i + 1] : null;
            if (Constants.DEBUG_FORMAT_TOOLS_IS_EMPTY_OR_COMMENTS) logInternal('  char: ${StringTools.toDisplayString(char)} nextChar: ${StringTools.toDisplayString(nextChar)}');

            if (isInEndOfLineComment)
            {
                if (char == '\n')
                {
                    isInEndOfLineComment = false;
                    if (Constants.DEBUG_FORMAT_TOOLS_IS_EMPTY_OR_COMMENTS) logInternal('  Now isInEndOfLineComment=false');
                    continue;
                }

                continue;
            }

            if (char == '/' && nextChar == '*')
            {
                blockCommentDepth++;
                if (Constants.DEBUG_FORMAT_TOOLS_IS_EMPTY_OR_COMMENTS) logInternal('  Now blockCommentDepth++: $blockCommentDepth');
                i++;
                continue;
            }

            if (char == '*' && nextChar == '/')
            {
                blockCommentDepth--;
                if (Constants.DEBUG_FORMAT_TOOLS_IS_EMPTY_OR_COMMENTS) logInternal('  Now blockCommentDepth--: $blockCommentDepth');
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
                if (Constants.DEBUG_FORMAT_TOOLS_IS_EMPTY_OR_COMMENTS) logInternal('  Now isInEndOfLineComment=true');
                i++;
                continue;
            }

            if (char == ' ' || char == '\t' || char == '\n')
                continue;

            if (Constants.DEBUG_FORMAT_TOOLS_IS_EMPTY_OR_COMMENTS) logInternal('  Result: false');
            return false;
        }

        if (blockCommentDepth > 0)
        {
            _logError('Text ended but blockCommentDepth > 0');
            return false;
        }

        if (Constants.DEBUG_FORMAT_TOOLS_IS_EMPTY_OR_COMMENTS) logInternal('  Result: true');
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

    static void _logError(String s)
    {
        logInternalError(s);
    }
}
