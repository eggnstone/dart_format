// ignore_for_file: always_put_control_body_on_new_line

import 'Constants/Constants.dart';
import 'Data/TextInfo.dart';
import 'TextSeparator.dart';
import 'Tools/LogTools.dart';
import 'Tools/StringTools.dart';
import 'Types/TextType.dart';

class LeadingWhitespaceRemover
{
    static String remove(String s, {required bool removeLeadingSpaces})
    {
        const String methodName = 'LeadingWhitespaceRemover.remove';
        final StringBuffer sb = StringBuffer();
        const String spacer = '  ';

        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$methodName()\nIN:\n-----\n${StringTools.toDisplayString(s)}\n-----\n$s\n-----');

        String leading = '';
        final List<TextInfo> parts = TextSeparator.separate(s, '$spacer  ');
        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer${parts.length} parts:');
        for (int i = 0; i < parts.length; i++)
        {
            final TextInfo part = parts[i];
            if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  Part #$i: ${part.type} ${StringTools.toDisplayString(part.text)}');

            if (part.type == TextType.Comment)
            {
                final String adjustedComment = _removeFromComment(leading, part.text, '$spacer      ');
                if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer    Adding comment:  ${StringTools.toDisplayString(adjustedComment)}');
                sb.write(adjustedComment);
                leading = _determineLeading(leading, part.text, '$spacer    ');
            }
            else
            {
                final String adjustedNonComment = _removeFromNonComment(part.text, '$spacer    ');
                if (removeLeadingSpaces && sb.isEmpty && adjustedNonComment.replaceAll(' ', '').isEmpty)
                {
                    if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer    Skipping leading spaces: ${StringTools.toDisplayString(adjustedNonComment)}');
                }
                else
                {
                    if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer    Adding non-comment: ${StringTools.toDisplayString(adjustedNonComment)}');
                    sb.write(adjustedNonComment);
                }

                leading = _determineLeading(leading, part.text, '$spacer    ');
            }
        }

        final String result = sb.toString();
        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER)
        {
            final String result2 = result
                .replaceAll(Constants.REMOVE_START, '')
                .replaceAll(Constants.REMOVE_END, '');
            logInternal('$methodName()\nOUT:\n-----\n${StringTools.toDisplayString(result2)}\n-----\n$result2\n-----');
        }

        return result;

        /*
        int currentPos = 0;
        while (true)
        {
            final int singleQuotePos = s.indexOf("'", currentPos);
            final int doubleQuotePos = s.indexOf('"', currentPos);
            final int blockCommentStartPos = s.indexOf('/*', currentPos);
            final int endOfLineCommentStartPos = s.indexOf('//', currentPos);
            if (blockCommentStartPos < 0 && endOfLineCommentStartPos < 0)
                break;

            int commentStartPos;
            int commentEndPos;
            if (blockCommentStartPos < 0 || (blockCommentStartPos >= 0 && endOfLineCommentStartPos >= 0 && endOfLineCommentStartPos < blockCommentStartPos))
            {
                // EndOfLine comment comes first
                commentStartPos = endOfLineCommentStartPos;

                final int endOfLineCommentEndPos = s.indexOf('\n', endOfLineCommentStartPos + 2);
                commentEndPos = endOfLineCommentEndPos < 0 ? s.length - 1 : endOfLineCommentEndPos;
            }
            else
            {
                // Block comment comes first
                commentStartPos = blockCommentStartPos;

                final int blockCommentEndPos = s.indexOf('*/', blockCommentStartPos + 2);
                if (blockCommentEndPos < 0)
                    throw DartFormatException.error('Block comment not closed.');

                commentEndPos = blockCommentEndPos + 2;
            }

            final String beforeComment = s.substring(currentPos, commentStartPos);
            if (beforeComment.isNotEmpty)
            {
                final String adjustedNonComment = _removeFromNonComment(beforeComment, spacer);
                if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('ADDING aNC: ${StringTools.toDisplayString(adjustedNonComment)}');
                leading = _determineLeading(leading, beforeComment, spacer);
                if (leading.isNotEmpty && leading.trim().isEmpty)
                {
                    if (adjustedNonComment.endsWith(leading))
                        sb.write(adjustedNonComment.substring(0, adjustedNonComment.length - leading.length));
                    else
                        sb.write(adjustedNonComment);
                }
                else
                    sb.write(adjustedNonComment);
            }

            final String comment = s.substring(commentStartPos, commentEndPos);
            final String adjustedComment = _removeFromComment(leading, comment, spacer);
            if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('ADDING aC: ${StringTools.toDisplayString(adjustedComment)}');
            sb.write(adjustedComment);
            leading = _determineLeading(leading, comment, spacer);

            currentPos = commentEndPos;
        }

        final String rest = s.substring(currentPos);
        if (rest.isNotEmpty)
        {
            final String adjustedNonCommentRest = _removeFromNonComment(rest, spacer);
            if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('adjustedNonCommentRest: ${StringTools.toDisplayString(adjustedNonCommentRest)}');
            /*if (adjustedNonCommentRest.trim().isEmpty)
            {
                if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('NOT ADDING raNC: ${StringTools.toDisplayString(adjustedNonCommentRest)}');
            }
            else
            {*/
            if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('ADDING raNC: ${StringTools.toDisplayString(adjustedNonCommentRest)}');
            sb.write(adjustedNonCommentRest);
            //}
        }

        final String result2 = sb.toString();
        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER)
        {
            final String result2 = result
                .replaceAll(Constants.REMOVE_START, '')
                .replaceAll(Constants.REMOVE_END, '');
            logInternal('$methodName()\nOUT:\n-----\n${StringTools.toDisplayString(result2)}\n-----\n$result2\n-----');
        }

        return result;
        /*.replaceAll('<COMMENT>', '')
            .replaceAll('</COMMENT>', '')
            .replaceAll('<NON-COMMENT>', '')
            .replaceAll('</NON-COMMENT>', '');*/*/
    }

    static String _determineLeading(String leading, String s, String spacer)
    {
        final int lastLineBreakPos = s.lastIndexOf('\n');
        if (lastLineBreakPos >= 0)
        {
            final String newLeading = s.substring(lastLineBreakPos + 1);
            if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('${spacer}New leading with line-break: ${StringTools.toDisplayString(newLeading)}');
            return newLeading;
        }

        final String newLeading = leading + s;
        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('${spacer}New leading without line-break: ${StringTools.toDisplayString(newLeading)}');
        return newLeading;
    }

    static String _removeFromNonComment(String s, String spacer)
    {
        final StringBuffer sb = StringBuffer();

        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER)
        {
            logInternal('${spacer}removeFromNonComment()');
            logInternal('$spacer  IN:  ${StringTools.toDisplayString(s)}');
        }

        final List<String> lines = s.split('\n');
        for (int i = 0; i < lines.length; i++)
        {
            final String line = lines[i];
            if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer    #${i.toString().padLeft(2, "0")}: ${StringTools.toDisplayString(line)}');

            if (i == 0)
            {
                sb.write(line);
            }
            else
            {
                sb.write('\n');
                sb.write(line.trimLeft());
            }
        }

        final String result = sb.toString();
        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  OUT: ${StringTools.toDisplayString(result)}');
        return result;
    }

    static String _removeFromComment(String leading, String s, String spacer)
    {
        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER)
        {
            logInternal('${spacer}removeFromComment()');
            logInternal('$spacer  leading: ${StringTools.toDisplayString(leading)}');
            logInternal('$spacer  s:       ${StringTools.toDisplayString(s)}');
        }

        return leading.isEmpty ? s : _removeFromCommentWithLeading(leading, s, '$spacer  ');
    }

    /*static String _removeFromCommentWithoutLeading(String s)
    {
        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('removeFromCommentWithoutLeading: ${StringTools.toDisplayString(s)}');

        return s.contains('\n')
            ? _removeFromCommentWithoutLeadingButWithLineBreak(s)
            : _removeFromCommentWithoutLeadingWithoutLineBreak(s);
    }*/

    /*static String _removeFromCommentWithoutLeadingWithoutLineBreak(String s)
    {
        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('removeFromCommentWithoutLeadingWithoutLineBreak: ${StringTools.toDisplayString(s)}');
        return s;
    }

    static String _removeFromCommentWithoutLeadingButWithLineBreak(String s)
    {
        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('removeFromCommentWithoutLeadingButWithLineBreak: ${StringTools.toDisplayString(s)}');
        return s;
        //return '<COMMENT-without-leading-but-with-line-break>$s</COMMENT-without-leading-but-with-line-break>';
    }*/

    static String _removeFromCommentWithLeading(String leading, String s, String spacer)
    {
        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER)
        {
            logInternal('${spacer}removeFromCommentWithLeading()');
            logInternal('$spacer  leading: ${StringTools.toDisplayString(leading)}');
            logInternal('$spacer  s:       ${StringTools.toDisplayString(s)}');
        }

        return leading.trim().isEmpty
            ? _removeFromCommentWithLeadingWhitespace(leading, s, '$spacer  ')
            : _removeFromCommentWithLeadingText(leading, s, '$spacer  ');
    }

    static String _removeFromCommentWithLeadingWhitespace(String leadingWhitespace, String s, String spacer)
    {
        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER)
        {
            logInternal('${spacer}removeFromCommentWithLeadingWhitespace()');
            logInternal('$spacer  leading: ${StringTools.toDisplayString(leadingWhitespace)}');
            logInternal('$spacer  s:       ${StringTools.toDisplayString(s)}');
        }

        int minIndentation = 0;
        final List<String> lines = s.split('\n');
        for (int i = 0; i < lines.length; i++)
        {
            final String line = lines[i];
            int indentation = line.length - line.trimLeft().length;
            if (i == 0)
                indentation += leadingWhitespace.length;

            if (i == 0 || indentation < minIndentation)
                minIndentation = indentation;
        }

        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  minIndentation: $minIndentation');

        final StringBuffer sb = StringBuffer();
        for (int i = 0; i < lines.length; i++)
        {
            final String line = lines[i];
            int indentation = line.length - line.trimLeft().length;
            if (i == 0)
                indentation += leadingWhitespace.length;

            final String newIndentation = ' ' * (indentation - minIndentation);

            if (i > 0)
                sb.write('\n');

            sb.write(newIndentation);
            sb.write(line.trimLeft());
        }

        final String result = sb.toString();
        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  OUT:     ${StringTools.toDisplayString(result)}');
        return result;
    }

    static String _removeFromCommentWithLeadingText(String leadingText, String s, String spacer)
    {
        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('${spacer}removeFromCommentWithLeadingText: ${StringTools.toDisplayString(s)}');

        return '<COMMENT-with-leading-text>$s</COMMENT-with-leading-text>';
    }
}
