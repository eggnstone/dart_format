// ignore_for_file: always_put_control_body_on_new_line

import 'Constants/Constants.dart';
import 'Data/TextInfo.dart';
import 'TextSeparator.dart';
import 'Tools/LogTools.dart';
import 'Tools/StringTools.dart';
import 'Types/TextType.dart';

class LeadingWhitespaceRemover
{
    static String removeFrom(String s, {required bool removeLeadingSpaces, String initialCurrentLineSoFar = '', String resultAfterLastLineBreak = ''})
    {
        const String methodName = 'LeadingWhitespaceRemover.removeFrom';
        const String spacer = '  ';

        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER)
        {
            logError('removeFrom()');
            logError('  currentLineSoFar:  ${StringTools.toDisplayString(initialCurrentLineSoFar)}');
            logError('  resultAfterLastLB: ${StringTools.toDisplayString(resultAfterLastLineBreak)}');
            logError('  s:                 ${StringTools.toDisplayString(s)}');
            logError('  =                  ${StringTools.toDisplayString(initialCurrentLineSoFar + s)}');
        }

        final StringBuffer sb = StringBuffer();

        String currentLineSoFar = initialCurrentLineSoFar;
        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logDebug('$methodName(currentLineSoFar: ${StringTools.toDisplayString(currentLineSoFar)})\nIN to remove():\n-----\n${StringTools.toDisplayString(s)}\n-----\n$s\n-----');

        final List<TextInfo> parts = TextSeparator.separate(s, '$spacer  ');
        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer${parts.length} parts:');
        for (int i = 0; i < parts.length; i++)
        {
            final TextInfo part = parts[i];
            if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  Part #$i: ${part.type} ${StringTools.toDisplayString(part.text)}');

            if (part.type == TextType.Comment)
            {
                final String resultSoFar = sb.toString();
                if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER)
                {
                    logInternal('  currentLineSoFar:         ${StringTools.toDisplayString(currentLineSoFar)}');
                    logInternal('  resultAfterLastLineBreak: ${StringTools.toDisplayString(resultAfterLastLineBreak)}');
                    logInternal('  Result so far:            ${StringTools.toDisplayString(resultSoFar)}');
                }

                int removedIndent = currentLineSoFar.length - currentLineSoFar.trimLeft().length;
                if (currentLineSoFar.trim().isNotEmpty || resultAfterLastLineBreak.trim().isNotEmpty || resultSoFar.trim().isNotEmpty)
                {
                    String removedText;
                    if (currentLineSoFar.endsWith(resultAfterLastLineBreak))
                    {
                        removedText = currentLineSoFar.substring(0, currentLineSoFar.length - resultAfterLastLineBreak.length);
                    }
                    else
                    {
                        if (currentLineSoFar.trimRight().endsWith(resultAfterLastLineBreak))
                        {
                            removedText = currentLineSoFar.substring(0, currentLineSoFar.trimRight().length - resultAfterLastLineBreak.length);
                        }
                        else
                        {
                            if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('currentLineSoFar (${StringTools.toDisplayString(currentLineSoFar)})'
                                    ' does not end with resultAfterLastLineBreak (${StringTools.toDisplayString(resultAfterLastLineBreak)})');
                            removedText = '';
                        }
                    }

                    removedIndent = removedText.length;

                    if (removedText.replaceAll(' ', '').isNotEmpty)
                    {
                        logDebug('removedText (${StringTools.toDisplayString(removedText)}) ($removedIndent) is not empty');
                        if (removedText.contains('*/'))
                        {
                            logDebug('  contains */');
                            removedIndent = 0;
                            removedText = '';
                        }
                        else
                        {
                            removedIndent = removedText.length - removedText.trimLeft().length;
                            logDebug('reduced removedIndent: ${StringTools.toDisplayString(removedIndent)}');
                            removedText = removedText.substring(removedIndent);
                            //throw Exception('removedText (${StringTools.toDisplayString(removedText)}) is not empty');
                        }
                    }

                    if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('removedText:         ${StringTools.toDisplayString(removedText)}');
                }
                else
                {
                    if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('removedText:         <only spaces or empty>');
                }

                if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('removedIndent:  $removedIndent');

                if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer    currentLineSoFarLength:  ${currentLineSoFar.length}');

                //final String adjustedComment = removeFromComment(sb.toString(), currentLineSoFar, part.text, '$spacer    ');
                final String adjustedComment = removeFromComment(currentLineSoFar, part.text, '$spacer    ');
                if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInfo('$spacer    Adding comment:  ${StringTools.toDisplayString(adjustedComment)}');
                /*//final String adjustedComment2 = adjustedComment;
                final String adjustedComment2 = removedIndent == 0
                    ? adjustedComment
                    : adjustedComment.splitMapJoin('\n',
                    onNonMatch: (String nonMatch) => 'NonMatch_${nonMatch}_NonMatch',
                    //onMatch: (Match match) => 'Match_${match}_Match'
                );
                if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer    Adding comment:  ${StringTools.toDisplayString(adjustedComment2)}');
                */
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
        /*if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER)
        {
            final String cleanedResult = result
                .replaceAll(Constants.REMOVE_START, '')
                .replaceAll(Constants.REMOVE_END, '');
            logInternal('$methodName END\nOUT from remove():\n-----\n${StringTools.toDisplayString(cleanedResult)}\n-----\n$cleanedResult\n-----');
        }*/

        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER)
        {
            logInternal('  currentLineSoFar:  ${StringTools.toDisplayString(initialCurrentLineSoFar)}');
            logInternal('  resultAfterLastLB: ${StringTools.toDisplayString(resultAfterLastLineBreak)}');
            logInternal('  s:                 ${StringTools.toDisplayString(s)}');
            logInternal('  =                  ${StringTools.toDisplayString(initialCurrentLineSoFar + s)}');
            logInternal('  OUT:               ${StringTools.toDisplayString(result)}');
            logInternal('  =                  ${StringTools.toDisplayString(initialCurrentLineSoFar + result)}');
        }

        return result;
    }

    static String removeFromComment(String currentLineSoFar, String s, String spacer)
    {
        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER)
        {
            logWarning('${spacer}removeFromComment()');
            logWarning('$spacer  currentLineSoFar:            ${StringTools.toDisplayString(currentLineSoFar)}');
            logWarning('$spacer  s:                           ${StringTools.toDisplayString(s)}');
        }

        final List<String> lines = s.split('\n');
        if (lines.length == 1)
        {
            final String result = lines[0].trimLeft();
            if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  Only 1 line:      ${StringTools.toDisplayString(result)}');
            return result;
        }

        //int minIndentation = currentLineSoFarLength;
        /*int minIndentation = removedIndentation;
        for (int i = 1; i < lines.length; i++)
        {
            final String line = lines[i];
            if (line.trim().isEmpty)
                continue;

            final int indentation = line.length - line.trimLeft().length;
            if (minIndentation == -1 || indentation < minIndentation)
                minIndentation = indentation;
        }

        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  minIndentation:              $minIndentation');*/

        /*if (minIndentation > toDoIndentation)
        {
            minIndentation -= toDoIndentation;
            if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  minIndentation-todo:         $minIndentation');
        }*/

        final StringBuffer sb = StringBuffer();
        //sb.write(Constants.INDENT_START);

        if (currentLineSoFar.isEmpty)
        {
            sb.write(Constants.INDENT_START);
            sb.write('00000000'); // Indicator for "completely empty"
            sb.write(Constants.INDENT_END);
        }
        else
        {
            if (currentLineSoFar.trim().isEmpty)
            {
                //throw Exception('TODO: empty after trim');
                sb.write(Constants.INDENT_START);
                sb.write('0000'); // Indicator for "empty after trim"
                sb.write(currentLineSoFar.length);
                sb.write(Constants.INDENT_END);
            }
            else if (currentLineSoFar.endsWith(' '))
            {
                sb.write(Constants.INDENT_START);
                sb.write('00'); // Indicator for "ends with a space"
                sb.write(currentLineSoFar.length);
                sb.write(Constants.INDENT_END);
            }
            else
            {
                sb.write(Constants.INDENT_START);
                sb.write(currentLineSoFar.length);
                sb.write(Constants.INDENT_END);
            }
        }

        sb.write(lines[0]);

        for (int i = 1; i < lines.length; i++)
        {
            final String line = lines[i];
            final int lineIndent = line.length - line.trimLeft().length;
            if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  Current indent: ${StringTools.padIntLeft(lineIndent, 2)} for line: ${StringTools.toDisplayString(line)}');

            /*final int relativeIndentation = currentLineSoFarLength - lineIndent;
            if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logError('$spacer  relativeIndentation: $relativeIndentation for line: ${StringTools.toDisplayString(line)}');*/

            sb.write('\n');
            //if (lineIndent >= 0)
            {
                sb.write(Constants.INDENT_START);
                sb.write(lineIndent);
                sb.write(Constants.INDENT_END);
            }

            sb.write(line.trimLeft());

            /*
            final int newIndentation = lineIndent - (minIndentation);// - removedIndentation) - removedIndentation;
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
            */
        }

        //sb.write(Constants.INDENT_END);

        final String result = sb.toString();
        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  OUT: ${StringTools.toDisplayString(result)}');
        return result;
    }

    /// Removes leading spaces from each line, but keeps the indentation of the first line.
    static String removeFromNonComment(String s, String spacer)
    {
        final StringBuffer sb = StringBuffer();

        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER)
        {
            logInternal('${spacer}removeLeadingSpaces2()');
            //logInternal('$spacer  toDoRename:  ${StringTools.toDisplayString(toDoRename)}');
            logInternal('$spacer  s:           ${StringTools.toDisplayString(s)}');
        }

        final List<String> lines = s.split('\n');
        if (lines.length == 1)
        {
            final String result = lines[0];
            if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  Only 1 line: ${StringTools.toDisplayString(result)}');
            return result;
        }

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
