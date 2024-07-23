// ignore_for_file: always_put_control_body_on_new_line

import '../Constants/Constants.dart';
import '../Exceptions/DartFormatException.dart';
import 'CommentTools.dart';
import 'LogTools.dart';
import 'StringTools.dart';

class FormatTools
{
    static bool isPeriodText(String s)
    => s == '.';

    static bool isCommaText(String s)
    {
        const String methodName = 'FormatTools.isCommaText';
        if (Constants.DEBUG_FORMAT_TOOLS) logInternal('# $methodName(${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)})');

        if (s.trim() == ',')
        {
            if (Constants.DEBUG_FORMAT_TOOLS) logInternal('  Simple comma found: ${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)}');
            return true;
        }

        final int commaPos = s.indexOf(',');
        if (commaPos == -1)
        {
            if (Constants.DEBUG_FORMAT_TOOLS) logInternal('  No comma found: ${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)}');
            return false;
        }

        final String beforeComma = s.substring(0, commaPos);
        if (!CommentTools.isEmptyOrComments(beforeComma))
        {
            if (Constants.DEBUG_FORMAT_TOOLS) logInternal('  beforeComma is not empty or comments: ${StringTools.toDisplayString(beforeComma, Constants.MAX_DEBUG_LENGTH)}');
            return false;
        }

        final String afterComma = s.substring(commaPos + 1);
        if (!CommentTools.isEmptyOrComments(afterComma))
        {
            if (Constants.DEBUG_FORMAT_TOOLS) logInternal('  afterComma is not empty or comments: ${StringTools.toDisplayString(afterComma, Constants.MAX_DEBUG_LENGTH)}');
            return false;
        }

        if (Constants.DEBUG_FORMAT_TOOLS) logInternal('  Comma surrounded by comments found: ${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)}');
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
}
