// ignore_for_file: always_put_control_body_on_new_line

import '../Constants/Constants.dart';
import 'LogTools.dart';
import 'StringTools.dart';

class CommentTools
{
    static bool isEmptyOrComments(String s)
    {
        const String methodName = 'CommentTools.isEmptyOrComments';
        if (Constants.DEBUG_FORMAT_TOOLS) logInternal('# $methodName(${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)})');

        bool isInEndOfLineComment = false;
        int blockCommentDepth = 0;

        for (int i = 0; i < s.length; i++)
        {
            final String char = s[i];
            final String? nextChar = i < s.length - 1 ? s[i + 1] : null;
            if (Constants.DEBUG_FORMAT_TOOLS) logInternal('  char: ${StringTools.toDisplayString(char)} nextChar: ${StringTools.toDisplayString(nextChar)}');

            if (isInEndOfLineComment)
            {
                if (char == '\n')
                {
                    isInEndOfLineComment = false;
                    if (Constants.DEBUG_FORMAT_TOOLS) logInternal('  Now isInEndOfLineComment=false');
                    continue;
                }

                continue;
            }

            if (char == '/' && nextChar == '*')
            {
                blockCommentDepth++;
                if (Constants.DEBUG_FORMAT_TOOLS) logInternal('  Now blockCommentDepth++: $blockCommentDepth');
                i++;
                continue;
            }

            if (char == '*' && nextChar == '/')
            {
                blockCommentDepth--;
                if (Constants.DEBUG_FORMAT_TOOLS) logInternal('  Now blockCommentDepth--: $blockCommentDepth');
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
                if (Constants.DEBUG_FORMAT_TOOLS) logInternal('  Now isInEndOfLineComment=true');
                i++;
                continue;
            }

            if (char == ' ' || char == '\t' || char == '\n')
                continue;

            if (Constants.DEBUG_FORMAT_TOOLS) logInternal('  Result: false');
            return false;
        }

        if (blockCommentDepth > 0)
        {
            _logError('Text ended but blockCommentDepth > 0');
            return false;
        }

        if (Constants.DEBUG_FORMAT_TOOLS) logInternal('  Result: true');
        return true;
    }


    static void _logError(String s)
    {
        logInternalError(s);
    }
}
