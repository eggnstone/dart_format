// ignore_for_file: always_put_control_body_on_new_line

import '../Constants/Constants.dart';
import '../Data/CommentInfo.dart';
import 'LogTools.dart';
import 'StringTools.dart';

class CommentTools
{
    static const String CLASS_NAME = 'CommentTools';

    static bool isEmptyOrComments(String s)
    {
        const String METHOD_NAME = '$CLASS_NAME.isEmptyOrComments';
        if (Constants.DEBUG_COMMENT_TOOLS) logInternal('> $METHOD_NAME(${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)})');

        final bool result = analyze(s).isEmptyOrComments;
        if (Constants.DEBUG_COMMENT_TOOLS) logInternal('< $METHOD_NAME(${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)}) < $result');

        return result;
    }

    static CommentInfo analyze(String s)
    {
        const String METHOD_NAME = '$CLASS_NAME.analyze';
        if (Constants.DEBUG_COMMENT_TOOLS) logInternal('> $METHOD_NAME(${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)})');

        final String sTrimmed = s.trim();
        if (sTrimmed.isEmpty)
        {
            const CommentInfo result = CommentInfo(isEmpty: true);
            if (Constants.DEBUG_COMMENT_TOOLS) logInternal('< $METHOD_NAME(${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)}) < is empty.');
            return result;
        }

        bool isInEndOfLineComment = false;
        int blockCommentDepth = 0;

        for (int i = 0; i < sTrimmed.length; i++)
        {
            final String char = sTrimmed[i];
            final String? nextChar = i < sTrimmed.length - 1 ? sTrimmed[i + 1] : null;
            if (Constants.DEBUG_COMMENT_TOOLS) logInternal('  char: ${StringTools.toDisplayString(char)} nextChar: ${StringTools.toDisplayString(nextChar)}');

            if (isInEndOfLineComment)
            {
                if (char != '\n')
                    continue;

                isInEndOfLineComment = false;
                if (Constants.DEBUG_COMMENT_TOOLS) logInternal('  Now isInEndOfLineComment=false');
                continue;
            }

            if (char == '/' && nextChar == '*')
            {
                blockCommentDepth++;
                if (Constants.DEBUG_COMMENT_TOOLS) logInternal('  Now blockCommentDepth++: $blockCommentDepth');
                i++;
                continue;
            }

            if (char == '*' && nextChar == '/')
            {
                blockCommentDepth--;
                if (Constants.DEBUG_COMMENT_TOOLS) logInternal('  Now blockCommentDepth--: $blockCommentDepth');
                if (blockCommentDepth < 0)
                {
                    const String errorMessage = 'Block comment ended but blockCommentDepth < 0';
                    const CommentInfo result = CommentInfo(hasError: true, errorMessage: errorMessage);
                    if (Constants.DEBUG_COMMENT_TOOLS) logInternal('< $METHOD_NAME(${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)}) < has error: $errorMessage');
                    return result;
                }

                i++;
                continue;
            }

            if (blockCommentDepth > 0)
                continue;

            if (char == '/' && nextChar == '/')
            {
                isInEndOfLineComment = true;
                if (Constants.DEBUG_COMMENT_TOOLS) logInternal('  Now isInEndOfLineComment=true');
                i++;
                continue;
            }

            if (char == ' ' || char == '\t' || char == '\n')
                continue;

            // ignore: avoid_redundant_argument_values
            const CommentInfo result = CommentInfo(isComment: false);
            if (Constants.DEBUG_COMMENT_TOOLS) logInternal('< $METHOD_NAME(${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)}) < is not a comment.');
            return result;
        }

        if (blockCommentDepth > 0)
        {
            const String errorMessage = 'Text ended but blockCommentDepth > 0';
            const CommentInfo result = CommentInfo(hasError: true, errorMessage: errorMessage);
            if (Constants.DEBUG_COMMENT_TOOLS) logInternal('< $METHOD_NAME(${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)}) < has error: $errorMessage');
            return result;
        }

        if (Constants.DEBUG_COMMENT_TOOLS) logInternal('< $METHOD_NAME(${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)}) < is a comment.');
        return const CommentInfo(isComment: true);
    }

    static String removeComments(String s)
    {
        const String METHOD_NAME = '$CLASS_NAME.removeComments';
        if (Constants.DEBUG_COMMENT_TOOLS) logInternal('> $METHOD_NAME(${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)})');

        final StringBuffer resultBuffer = StringBuffer();
        bool isInEndOfLineComment = false;
        int blockCommentDepth = 0;

        for (int i = 0; i < s.length; i++)
        {
            final String char = s[i];
            final String? nextChar = i < s.length - 1 ? s[i + 1] : null;
            if (Constants.DEBUG_COMMENT_TOOLS) logInternal('  char: ${StringTools.toDisplayString(char)} nextChar: ${StringTools.toDisplayString(nextChar)}');

            if (isInEndOfLineComment)
            {
                if (char != '\n')
                    continue;

                isInEndOfLineComment = false;
                if (Constants.DEBUG_COMMENT_TOOLS) logInternal('  Now isInEndOfLineComment=false');
                resultBuffer.write('\n');
                continue;
            }

            if (char == '/' && nextChar == '*')
            {
                blockCommentDepth++;
                if (Constants.DEBUG_COMMENT_TOOLS) logInternal('  Now blockCommentDepth++: $blockCommentDepth');
                i++;
                continue;
            }

            if (char == '*' && nextChar == '/')
            {
                blockCommentDepth--;
                if (Constants.DEBUG_COMMENT_TOOLS) logInternal('  Now blockCommentDepth--: $blockCommentDepth');
                if (blockCommentDepth < 0)
                {
                    const String errorMessage = 'Block comment ended but blockCommentDepth < 0';
                    if (Constants.DEBUG_COMMENT_TOOLS) logInternal('< $METHOD_NAME(${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)}) < has error: $errorMessage');
                    return s;
                }

                i++;
                continue;
            }

            if (blockCommentDepth > 0)
                continue;

            if (char == '/' && nextChar == '/')
            {
                isInEndOfLineComment = true;
                if (Constants.DEBUG_COMMENT_TOOLS) logInternal('  Now isInEndOfLineComment=true');
                i++;
                continue;
            }

            resultBuffer.write(char);

            if (char == ' ' || char == '\t' || char == '\n')
                continue;

            // Is comment => continue
            if (Constants.DEBUG_COMMENT_TOOLS) logInternal('  Is a comment???');
        }

        if (blockCommentDepth > 0)
        {
            const String errorMessage = 'Text ended but blockCommentDepth > 0';
            if (Constants.DEBUG_COMMENT_TOOLS) logInternal('< $METHOD_NAME(${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)}) < has error: $errorMessage');
            return s;
        }

        final String result = resultBuffer.toString();
        if (Constants.DEBUG_COMMENT_TOOLS) logInternal('< $METHOD_NAME(${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)}) < ${StringTools.toDisplayString(result, Constants.MAX_DEBUG_LENGTH)}');

        return result;
    }
}
