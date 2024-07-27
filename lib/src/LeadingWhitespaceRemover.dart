// ignore_for_file: always_put_control_body_on_new_line

import 'Constants/Constants.dart';
import 'Data/TextInfo.dart';
import 'TextSeparator.dart';
import 'Tools/LogTools.dart';
import 'Tools/StringTools.dart';
import 'Types/TextType.dart';

class LeadingWhitespaceRemover
{
    static String remove(String s, {required bool removeLeadingSpaces, String initialCurrentLineSoFar = ''})
    {
        const String methodName = 'LeadingWhitespaceRemover.remove';
        final StringBuffer sb = StringBuffer();
        const String spacer = '  ';

        String currentLineSoFar = initialCurrentLineSoFar;
        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$methodName(currentLineSoFar: ${StringTools.toDisplayString(currentLineSoFar)})\nIN:\n-----\n${StringTools.toDisplayString(s)}\n-----\n$s\n-----');

        //String leading = '';
        final List<TextInfo> parts = TextSeparator.separate(s, '$spacer  ');
        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer${parts.length} parts:');
        for (int i = 0; i < parts.length; i++)
        {
            final TextInfo part = parts[i];
            if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  Part #$i: ${part.type} ${StringTools.toDisplayString(part.text)}');

            if (part.type == TextType.Comment)
            {
                final String adjustedComment = _removeFromComment(currentLineSoFar, part.text, '$spacer      ');
                if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer    Adding comment:  ${StringTools.toDisplayString(adjustedComment)}');
                sb.write(adjustedComment);
                //leading = _determineLeading(leading, part.text, '$spacer    ');
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

                //leading = _determineLeading(leading, part.text, '$spacer    ');
            }

            // ignore: use_string_buffers
            currentLineSoFar += part.text;
            final int lastLineBreakPos = currentLineSoFar.lastIndexOf('\n');
            if (lastLineBreakPos >= 0)
                currentLineSoFar = currentLineSoFar.substring(lastLineBreakPos + 1);
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

    /*static String _determineLeading(String leading, String s, String spacer)
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
    }*/

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
            if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer    #${StringTools.padIntLeft0(i, 2)}: ${StringTools.toDisplayString(line)}');

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

    /*static String _removeFromComment(String leading, String s, String spacer)
    {
        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER)
        {
            logInternal('${spacer}removeFromComment()');
            logInternal('$spacer  leading: ${StringTools.toDisplayString(leading)}');
            logInternal('$spacer  s:       ${StringTools.toDisplayString(s)}');
        }

        return leading.isEmpty ? s : _removeFromCommentWithLeading(leading, s, '$spacer  ');
    }*/

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

    /*static String _removeFromComment(String? currentLineSoFar, String s, String spacer)
    {
        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER)
        {
            logInternal('${spacer}removeFromComment()');
            logInternal('$spacer  currentLineSoFar: ${StringTools.toDisplayString(currentLineSoFar)}');
            logInternal('$spacer  s:                ${StringTools.toDisplayString(s)}');
        }

        return leading.trim().isEmpty
            ? _removeFromCommentWithLeadingWhitespace(currentLineSoFar, s, '$spacer  ')
            : _removeFromCommentWithLeadingText(*//*leading,*//* s, '$spacer  ');
    }*/

    static String _removeFromComment(String? currentLineSoFar, String s, String spacer)
    {
        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER)
        {
            logInternal('${spacer}_removeFromComment()');
            logInternal('$spacer  currentLineSoFar: ${StringTools.toDisplayString(currentLineSoFar)}');
            logInternal('$spacer  s:                ${StringTools.toDisplayString(s)}');
        }

        final List<String> lines = s.split('\n');
        if (lines.length == 1)
        {
            final String result = lines[0].trimLeft();
            if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  Only 1 line:      ${StringTools.toDisplayString(result)}');
            return result;
        }

        final int currentLineSoFarIndentation = currentLineSoFar == null ? 0 : currentLineSoFar.length - currentLineSoFar.trimLeft().length;
        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  currentLineSoFarIndentation: $currentLineSoFarIndentation');
        //final int indentation0 = lines[0].length - lines[0].trimLeft().length + currentLineSoFarIndentation;
        //if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  indentation0:                      $indentation0');

        int minIndentation = currentLineSoFarIndentation;
        for (int i = 1; i < lines.length; i++)
        {
            final String line = lines[i];
            final int indentation = line.length - line.trimLeft().length;
            if (/*minIndentation == -1 ||*/ indentation < minIndentation)
                minIndentation = indentation;
        }

        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  minIndentation:              $minIndentation');
        /*if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  minIndentation without first line: $minIndentation');
        if (currentLineSoFarIndentation < minIndentation)
            minIndentation = currentLineSoFarIndentation;
        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  minIndentation with    first line: $minIndentation');*/

        final StringBuffer sb = StringBuffer();

        if (minIndentation < currentLineSoFarIndentation) {
            final int newIndentation = currentLineSoFarIndentation - minIndentation;
                sb.write(' ' * newIndentation);
            }

    sb.write(lines[0].trimLeft());

        for (int i = 1; i < lines.length; i++)
        {
            final String line = lines[i];
            final int indentation = line.length - line.trimLeft().length;
            if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  Current indentation:  ${StringTools.padIntLeft(indentation, 2)} for line: ${StringTools.toDisplayString(line)}');

            final int newIndentation = indentation - minIndentation;
            if (newIndentation <= 0)
            {
                if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  Negative indentation: ${StringTools.padIntLeft(newIndentation, 2)} for line: ${StringTools.toDisplayString(line)}');
                sb.write('\n');
                sb.write(line.trimLeft());
                continue;
            }

            final String newIndentationText = ' ' * newIndentation;
            if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  New indentation:      ${StringTools.padIntLeft(newIndentation, 2)} for line: ${StringTools.toDisplayString(line)}');

            sb.write('\n');
            sb.write(newIndentationText);
            sb.write(line.trimLeft());
        }

        final String result = sb.toString();
        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  OUT:     ${StringTools.toDisplayString(result)}');
        return result;
    }

    /*static String _removeFromCommentWithLeadingText(*//*String leadingText,*//* String s, String spacer)
    {
        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('${spacer}removeFromCommentWithLeadingText: ${StringTools.toDisplayString(s)}');

        return s;
        //return '<COMMENT-with-leading-text>$s</COMMENT-with-leading-text>';
    }*/
}
