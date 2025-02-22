// ignore_for_file: always_put_control_body_on_new_line

import '../Constants/Constants.dart';
import '../Exceptions/DartFormatException.dart';
import 'CommentTools.dart';
import 'LogTools.dart';
import 'StringTools.dart';

class FormatTools
{
    static const String CLASS_NAME = 'FormatTools';

    static bool isPeriodText(String s)
    => s == '.';

    static bool isCommaText(String s)
    {
        const String METHOD_NAME = '$CLASS_NAME.isCommaText';
        if (Constants.DEBUG_FORMAT_TOOLS) logInternal('> $METHOD_NAME(${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)})');

        final String cleanedText = CommentTools.removeComments(s);

        if (cleanedText.trim() == ',')
        {
            if (Constants.DEBUG_FORMAT_TOOLS) logInternal('< $METHOD_NAME(${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)}) < Simple comma found.');
            return true;
        }

        final int commaPos = cleanedText.indexOf(',');
        if (Constants.DEBUG_FORMAT_TOOLS) logInternal('  commaPos: $commaPos');
        if (commaPos == -1)
        {
            if (Constants.DEBUG_FORMAT_TOOLS) logInternal('< $METHOD_NAME(${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)}) < No comma found.');
            return false;
        }

        if (Constants.DEBUG_FORMAT_TOOLS) logInternal('< $METHOD_NAME(${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)}) < Comma found.');
        return true;
    }

    static String resolveIgnores(String s)
    {
        String result = s;
        while (result.contains(Constants.REMOVE_START))
        {
            final int start = result.indexOf(Constants.REMOVE_START);
            final int end = result.indexOf(Constants.REMOVE_END, start + Constants.REMOVE_START.length);
            if (end == -1)
                throw DartFormatException.error('Internal error: Missing ${Constants.REMOVE_END} in result.');

            result = result.substring(0, start) + result.substring(end + Constants.REMOVE_END.length);
        }

        return result;
    }

    static String removeIgnoreTags(String s)
    {
        String result = s;

        while (result.contains(Constants.REMOVE_START))
        {
            final int start = result.indexOf(Constants.REMOVE_START);
            final int end = result.indexOf(Constants.REMOVE_END, start + Constants.REMOVE_START.length);
            if (end == -1)
                throw DartFormatException.error('Internal error: Missing ${Constants.REMOVE_END} in result.');

            result = result.substring(0, start)
                + result.substring(start + Constants.REMOVE_START.length, end)
                + result.substring(end + Constants.REMOVE_END.length);
        }

        return result;
    }

    static String removeIndentTags(String s)
    {
        final StringBuffer sb = StringBuffer();

        int currentPos = 0;
        int indentStartPos;
        while ((indentStartPos = s.indexOf(Constants.INDENT_START, currentPos)) >= 0)
        {
            final int indentEndPos = s.indexOf(Constants.INDENT_END, indentStartPos + Constants.INDENT_START.length);
            if (indentEndPos == -1)
                throw DartFormatException.error('Internal error: Missing ${Constants.INDENT_END} in result.');

            sb.write(s.substring(currentPos, indentStartPos));

            currentPos = indentEndPos + Constants.INDENT_END.length;
        }

        sb.write(s.substring(currentPos));

        return sb.toString();
    }

    static String resolveIndents(String s)
    {
        final StringBuffer sb = StringBuffer();

        if (Constants.DEBUG_FORMAT_TOOLS)
        {
            logDebug('resolveIndents()');
            logDebug('  \n$s');
        }

        int currentPos = 0;
        String currentText = '';
        int indentStartPos;
        while ((indentStartPos = s.indexOf(Constants.INDENT_START, currentPos)) >= 0)
        {
            if (Constants.DEBUG_FORMAT_TOOLS) logDebug('  Indent found:');

            if (Constants.DEBUG_FORMAT_TOOLS) logDebug('    currentText:       ${StringTools.toDisplayString(currentText)}');

            if (Constants.DEBUG_FORMAT_TOOLS) logDebug('    indentStartPos:    $indentStartPos');
            final int indentEndPos = s.indexOf(Constants.INDENT_END, indentStartPos + Constants.INDENT_START.length);
            if (Constants.DEBUG_FORMAT_TOOLS) logDebug('    indentEndPos:      $indentEndPos');
            if (indentEndPos == -1)
                throw Exception('Missing ${Constants.INDENT_END} in result.');

            final String indentText = s.substring(indentStartPos + Constants.INDENT_START.length, indentEndPos);
            if (Constants.DEBUG_FORMAT_TOOLS) logDebug('    indentText:        ${StringTools.toDisplayString(indentText)}');
            final int indent = int.parse(indentText);
            if (Constants.DEBUG_FORMAT_TOOLS) logDebug('    indent:            $indent');

            if (indent < 0)
                throw Exception('Negative indent not allowed: $indent');

            final String previousText = s.substring(currentPos, indentStartPos);
            currentText = _writeExceptLastLine(sb, currentText, previousText, 'previousText');

            if (Constants.DEBUG_FORMAT_TOOLS) logDebug('    currentLineLength: ${currentText.length}');
            final int finalIndent = indent - currentText.length;

            if (finalIndent > 0)
            {
                if (Constants.DEBUG_FORMAT_TOOLS) logDebug('    finalIndent (pos): $finalIndent');
                final String finalIndentText = ' ' * finalIndent;
                if (finalIndentText.isNotEmpty)
                {
                    currentText = _writeExceptLastLine(sb, currentText, finalIndentText, 'finalIndentText');
                    // currentLineLength = currentText.length;
                    //logDebug('    currentLineLength: $currentLineLength');
                }
            }
            else if (finalIndent < 0)
            {
                if (Constants.DEBUG_FORMAT_TOOLS) logDebug('    finalIndent (neg): $finalIndent => trying to reduce indent');
                if (indentText.startsWith('00'))
                {
                    if (indentText == '00000000')
                    {
                        // 00000000 => Indicator for "completely empty"
                        if (Constants.DEBUG_FORMAT_TOOLS) logDebug('    Previous text is completely empty => remove trailing spaces');
                        currentText = StringTools.removeTrailingSpaces(currentText);
                    }
                    else if (indentText.startsWith('0000'))
                    {
                        // 0000 => Indicator for "empty after trim"
                        if (Constants.DEBUG_FORMAT_TOOLS) logDebug('    Previous text is empty after trim => remove trailing spaces except and add old amount of spaces');
                        currentText = StringTools.removeTrailingSpaces(currentText) + ' ' * indent;
                    }
                    else
                    {
                        // 00 => Indicator for "ends with a space"
                        if (Constants.DEBUG_FORMAT_TOOLS) logDebug('    Previous text ends with a space => remove trailing spaces except one');
                        // ignore: prefer_interpolation_to_compose_strings
                        currentText = StringTools.removeTrailingSpaces(currentText) + ' ';
                    }
                }
                else
                {
                    final int availableSpaces = currentText.length - currentText.trimRight().length;
                    if (availableSpaces > 0)
                    {
                        if (availableSpaces >= -finalIndent)
                        {
                            if (Constants.DEBUG_FORMAT_TOOLS) logDebug('    currentText1:      ${StringTools.toDisplayString(currentText)}');
                            if (Constants.DEBUG_FORMAT_TOOLS) logDebug('    availableSpaces    $availableSpaces');
                            currentText = currentText.substring(0, currentText.length + finalIndent);
                            if (Constants.DEBUG_FORMAT_TOOLS) logDebug('    currentText2:      ${StringTools.toDisplayString(currentText)}');
                        }
                        else
                        {
                            throw Exception('Not enough spaces to reduce indent: $availableSpaces < $finalIndent');
                        }
                    }
                    else
                    {
                        if (Constants.DEBUG_FORMAT_TOOLS) logDebug('    availableSpaces <= 0 => cannot not reduce');
                    }
                }
            }
            else
            {
                if (Constants.DEBUG_FORMAT_TOOLS) logDebug('    zero finalIndent');
            }

            currentPos = indentEndPos + Constants.INDENT_END.length;
        }

        final String restText = s.substring(currentPos);
        if (restText.isNotEmpty)
        {
            sb.write(currentText);
            sb.write(restText);
            if (Constants.DEBUG_FORMAT_TOOLS) logDebug('+ rest:                ${StringTools.toDisplayString(currentText + restText)}');
        }

        return sb.toString();
    }

    static String _writeExceptLastLine(StringBuffer sb, String currentLine, String newText, String label)
    {
        if (Constants.DEBUG_FORMAT_TOOLS) logDebug('      writeExceptLastLine($label)');
        if (Constants.DEBUG_FORMAT_TOOLS) logDebug('        currentLine: ${StringTools.toDisplayString(currentLine)}');
        if (Constants.DEBUG_FORMAT_TOOLS) logDebug('        newText:     ${StringTools.toDisplayString(newText)}');

        final int lastLineBreak = newText.lastIndexOf('\n');
        if (lastLineBreak == -1)
        {
            if (Constants.DEBUG_FORMAT_TOOLS) logDebug('        writing:     <nothing>');
            if (Constants.DEBUG_FORMAT_TOOLS) logDebug('        keeping:     ${StringTools.toDisplayString(currentLine + newText)}');
            return currentLine + newText;
        }

        if (Constants.DEBUG_FORMAT_TOOLS) logDebug('+       writing:     ${StringTools.toDisplayString(currentLine + newText.substring(0, lastLineBreak + 1))}');
        if (Constants.DEBUG_FORMAT_TOOLS) logDebug('        keeping:     ${StringTools.toDisplayString(newText.substring(lastLineBreak + 1))}');
        sb.write(currentLine + newText.substring(0, lastLineBreak + 1));
        return newText.substring(lastLineBreak + 1);
    }
}
