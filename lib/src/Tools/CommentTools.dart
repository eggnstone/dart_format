// ignore_for_file: always_put_control_body_on_new_line

import '../Constants/Constants.dart';
import '../Data/CommentInfo.dart';
import 'LogTools.dart';
import 'StringTools.dart';

class CommentTools
{
    static bool isEmptyOrComments(String s)
    => analyze(s).isEmptyOrComments;

    static CommentInfo analyze(String s)
    {
        const String methodName = 'CommentTools.analyze';
        if (Constants.DEBUG_FORMAT_TOOLS) logInternal('# $methodName(${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)})');

        final String sTrimmed = s.trim();
        if (sTrimmed.isEmpty)
            return const CommentInfo(isEmpty: true);

        bool isInEndOfLineComment = false;
        int blockCommentDepth = 0;

        for (int i = 0; i < sTrimmed.length; i++)
        {
            final String char = sTrimmed[i];
            final String? nextChar = i < sTrimmed.length - 1 ? sTrimmed[i + 1] : null;
            if (Constants.DEBUG_FORMAT_TOOLS) logInternal('  char: ${StringTools.toDisplayString(char)} nextChar: ${StringTools.toDisplayString(nextChar)}');

            if (isInEndOfLineComment)
            {
                if (char != '\n')
                    continue;

                isInEndOfLineComment = false;
                if (Constants.DEBUG_FORMAT_TOOLS) logInternal('  Now isInEndOfLineComment=false');
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
                    return const CommentInfo(hasError: true, errorMessage: 'Block comment ended but blockCommentDepth < 0');

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
            // ignore: avoid_redundant_argument_values
            return const CommentInfo(isComment: false);
        }

        if (blockCommentDepth > 0)
            return const CommentInfo(hasError: true, errorMessage: 'Text ended but blockCommentDepth > 0');

        if (Constants.DEBUG_FORMAT_TOOLS) logInternal('  Result: true');
        return const CommentInfo(isComment: true);
    }
}
