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
        const String spacer = '  ';
        final StringBuffer sb = StringBuffer();

        String currentLineSoFar = initialCurrentLineSoFar;
        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$methodName(currentLineSoFar: ${StringTools.toDisplayString(currentLineSoFar)})\nIN:\n-----\n${StringTools.toDisplayString(s)}\n-----\n$s\n-----');

        final List<TextInfo> parts = TextSeparator.separate(s, '$spacer  ');
        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer${parts.length} parts:');
        for (int i = 0; i < parts.length; i++)
        {
            final TextInfo part = parts[i];
            if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  Part #$i: ${part.type} ${StringTools.toDisplayString(part.text)}');

            if (part.type == TextType.Comment)
            {
                final String adjustedComment = removeFromComment(currentLineSoFar, part.text, '$spacer    ');
                if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer    Adding comment:  ${StringTools.toDisplayString(adjustedComment)}');
                sb.write(adjustedComment);
            }
            else
            {
                final String adjustedNonComment = removeFromNonComment(part.text, '$spacer    ');
                if (removeLeadingSpaces && sb.isEmpty && adjustedNonComment.replaceAll(' ', '').isEmpty)
                {
                    if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer    Skipping leading spaces: ${StringTools.toDisplayString(adjustedNonComment)}');
                }
                else
                {
                    if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer    Adding non-comment: ${StringTools.toDisplayString(adjustedNonComment)}');
                    sb.write(adjustedNonComment);
                }
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
            final String cleanedResult = result
                .replaceAll(Constants.REMOVE_START, '')
                .replaceAll(Constants.REMOVE_END, '');
            logInternal('$methodName END\nOUT:\n-----\n${StringTools.toDisplayString(cleanedResult)}\n-----\n$cleanedResult\n-----');
        }

        return result;
    }

    static String removeFromComment(String? currentLineSoFar, String s, String spacer)
    {
        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER)
        {
            logInternal('${spacer}removeFromComment(currentLineSoFar: ${StringTools.toDisplayString(currentLineSoFar)})');
            logInternal('$spacer  IN:  ${StringTools.toDisplayString(s)}');
        }

        final List<String> lines = s.split('\n');
        if (lines.length == 1)
        {
            final String result = lines[0].trimLeft();
            if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  Only 1 line:      ${StringTools.toDisplayString(result)}');
            return result;
        }

        /*
        final int currentLineSoFarIndentation = currentLineSoFar == null ? 0 : currentLineSoFar.length - currentLineSoFar.trimLeft().length;
        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  currentLineSoFarIndentation: $currentLineSoFarIndentation');
        */
        int currentLineSoFarIndentation = 0;
        if (currentLineSoFar != null)
        {
            final int lastBlockCommentEndPos = currentLineSoFar.lastIndexOf('*''/');
            if (lastBlockCommentEndPos == -1)
                currentLineSoFarIndentation = currentLineSoFar.length - currentLineSoFar.trimLeft().length;
            else
                currentLineSoFarIndentation = 0;//lastBlockCommentEndPos + 2;

            if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  currentLineSoFarIndentation: $currentLineSoFarIndentation');
        }

        int minIndentation = currentLineSoFarIndentation;
        for (int i = 1; i < lines.length; i++)
        {
            final String line = lines[i];
            if (line.trim().isEmpty)
                continue;

            final int indentation = line.length - line.trimLeft().length;
            if (indentation < minIndentation)
                minIndentation = indentation;
        }

        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  minIndentation:              $minIndentation');

        final StringBuffer sb = StringBuffer();

        if (minIndentation < currentLineSoFarIndentation)
        {
            final int line0Indentation = currentLineSoFarIndentation - minIndentation;
            final String line0IndentationText = ' ' * line0Indentation;
            sb.write(line0IndentationText);
            if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  line0 indent:   ${StringTools.padIntLeft(line0Indentation, 2)} for line: ${StringTools.toDisplayString(lines[0])}');
        }

        //if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  line0:                       ${StringTools.toDisplayString(lines[0])}');
        //if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  line0.trimLeft():            ${StringTools.toDisplayString(lines[0].trimLeft())}');
        sb.write(lines[0].trimLeft());

        for (int i = 1; i < lines.length; i++)
        {
            final String line = lines[i];
            final int indentation = line.length - line.trimLeft().length;
            if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  Current indent: ${StringTools.padIntLeft(indentation, 2)} for line: ${StringTools.toDisplayString(line)}');

            final int newIndentation = indentation - minIndentation;
            if (newIndentation <= 0)
            {
                if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  Neg. indent:    ${StringTools.padIntLeft(newIndentation, 2)} for line: ${StringTools.toDisplayString(line)}');
                sb.write('\n');
                sb.write(line.trimLeft());
                continue;
            }

            final String newIndentationText = ' ' * newIndentation;
            if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  New indent:     ${StringTools.padIntLeft(newIndentation, 2)} for line: ${StringTools.toDisplayString(line)}');

            sb.write('\n');
            sb.write(newIndentationText);
            sb.write(line.trimLeft());
        }

        final String result = sb.toString();
        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  OUT: ${StringTools.toDisplayString(result)}');
        return result;
    }

    static String removeFromNonComment(String s, String spacer)
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
}
