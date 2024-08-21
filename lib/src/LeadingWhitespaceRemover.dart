// ignore_for_file: always_put_control_body_on_new_line

import 'Constants/Constants.dart';
import 'Data/TextInfo.dart';
import 'TextSeparator.dart';
import 'Tools/LogTools.dart';
import 'Tools/StringTools.dart';
import 'Types/TextType.dart';

class LeadingWhitespaceRemover
{
    static String removeFrom(String s, {required bool removeLeadingSpaces, String initialCurrentLineSoFar = '', String resultAfterLastLineBreak = '', bool isString = false})
    {
        const String methodName = 'LeadingWhitespaceRemover.removeFrom';
        const String spacer = '  ';

        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER)
        {
            logDebug('removeFrom()');
            logDebug('  currentLineSoFar:  ${StringTools.toDisplayString(initialCurrentLineSoFar)}');
            logDebug('  resultAfterLastLB: ${StringTools.toDisplayString(resultAfterLastLineBreak)}');
            logDebug('  s:                 ${StringTools.toDisplayString(s)}');
            logDebug('  =                  ${StringTools.toDisplayString(initialCurrentLineSoFar + s)}');
        }

        if (isString)
        {
            final bool isTripleQuotedString = s.startsWith("'''") || s.startsWith("r'''") || s.startsWith('"""') || s.startsWith('r"""');
            if (isTripleQuotedString)
                return removeFromTripleQuotedString(s, spacer);

            return removeFromNonComment(s, spacer);
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

                if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer    currentLineSoFarLength:  ${currentLineSoFar.length}');

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
        const String methodName = 'LeadingWhitespaceRemover.removeFromComment';
        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER)
        {
            logDebug('${spacer}$methodName()');
            logDebug('$spacer  currentLineSoFar:            ${StringTools.toDisplayString(currentLineSoFar)}');
            logDebug('$spacer  s:                           ${StringTools.toDisplayString(s)}');
        }

        final List<String> lines = s.split('\n');
        if (lines.length == 1)
        {
            final String result = lines[0].trimLeft();
            if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  Only 1 line:      ${StringTools.toDisplayString(result)}');
            return result;
        }

        final StringBuffer sb = StringBuffer();

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

            sb.write('\n');
            sb.write(Constants.INDENT_START);
            sb.write(lineIndent);
            sb.write(Constants.INDENT_END);
            sb.write(line.trimLeft());
        }

        final String result = sb.toString();
        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  OUT: ${StringTools.toDisplayString(result)}');
        return result;
    }

    /// Removes leading spaces from each line, but keeps the indentation of the first line.
    static String removeFromNonComment(String s, String spacer)
    {
        const String methodName = 'LeadingWhitespaceRemover.removeFromNonComment';
        final StringBuffer sb = StringBuffer();

        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER)
        {
            logInternal('${spacer}$methodName()');
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

    static String removeFromTripleQuotedString(String s, String spacer)
    {
        const String methodName = 'LeadingWhitespaceRemover.removeFromTripleQuotedString';
        final StringBuffer sb = StringBuffer();

        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER)
        {
            logInternal('${spacer}$methodName()');
            logInternal('$spacer  s:           ${StringTools.toDisplayString(s)}');
        }

        final List<String> lines = s.split('\n');
        if (lines.length == 1)
        {
            final String result = lines[0].trimLeft();
            if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  Only 1 line: ${StringTools.toDisplayString(result)}');
            return result;
        }

        for (int i = 0; i < lines.length; i++)
        {
            final String line = lines[i];
            if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer    #${StringTools.padIntLeft0(i, 2)}: ${StringTools.toDisplayString(line)}');

            if (i == 0)
            {
                sb.write(line.trimLeft());
            }
            else
            {
                final int lineIndent = line.length - line.trimLeft().length;
                sb.write('\n');
                sb.write(Constants.INDENT_START);
                sb.write(lineIndent);
                sb.write(Constants.INDENT_END);
                sb.write(line.trimLeft());
            }
        }

        final String result = sb.toString();
        if (Constants.DEBUG_LEADING_WHITESPACE_REMOVER) logInternal('$spacer  OUT: ${StringTools.toDisplayString(result)}');
        return result;
    }
}
