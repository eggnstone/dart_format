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

        logInfo('resolveIndents()');
        logInfo('  \n$s');

        int currentPos = 0;
        String currentText = '';
        int indentStartPos;
        while ((indentStartPos = s.indexOf(Constants.INDENT_START, currentPos)) >= 0)
        {
            logInfo('  Indent found:');

            logInfo('    currentText:       ${StringTools.toDisplayString(currentText)}');

            logInfo('    indentStartPos:    $indentStartPos');
            final int indentEndPos = s.indexOf(Constants.INDENT_END, indentStartPos + Constants.INDENT_START.length);
            logInfo('    indentEndPos:      $indentEndPos');
            if (indentEndPos == -1)
                throw Exception('Missing ${Constants.INDENT_END} in result.');

            final String indentText = s.substring(indentStartPos + Constants.INDENT_START.length, indentEndPos);
            logInfo('    indentText:        ${StringTools.toDisplayString(indentText)}');
            final int indent = int.parse(indentText);
            logInfo('    indent:            $indent');

            if (indent < 0)
                throw Exception('Negative indent not allowed: $indent');

            final String previousText = s.substring(currentPos, indentStartPos);
            currentText = _writeExceptLastLine(sb, currentText, previousText, 'previousText');

            logInfo('    currentLineLength: ${currentText.length}');
            final int finalIndent = indent - currentText.length;

            if (finalIndent > 0)
            {
                logInfo('    finalIndent (pos): $finalIndent');
                final String finalIndentText = ' ' * finalIndent;
                if (finalIndentText.isNotEmpty)
                {
                    currentText = _writeExceptLastLine(sb, currentText, finalIndentText, 'finalIndentText');
                   // currentLineLength = currentText.length;
                    //logInfo('    currentLineLength: $currentLineLength');
                }
            }
            else if (finalIndent < 0)
            {
                logInfo('    finalIndent (neg): $finalIndent => trying to reduce indent');
                if (indentText.startsWith('00'))
                {
                    if (indentText == '00000000')
                    {
                        logWarning('    Previous text is completely empty => remove trailing spaces');
                        currentText = StringTools.removeTrailingSpaces(currentText);
                    }
                    else if (indentText.startsWith('0000'))
                    {
                        //logWarning('    Previous text is empty after trim => ?');
                        throw Exception('TODO: Previous text is empty after trim');
                    }
                    else
                    {
                        logWarning('    Previous text ends with a space => remove trailing spaces except one');
                        // ignore: prefer_interpolation_to_compose_strings
                        currentText = StringTools.removeTrailingSpaces(currentText) + ' ';
                    }
                }
                else
                {
                    final int availableSpaces = currentText.length - currentText.trimRight().length;
                    if (availableSpaces > 0)
                    {
                        logInfo('    availableSpaces    $availableSpaces');
                        currentText = currentText.substring(0, currentText.length - availableSpaces);
                        logInfo('    currentText:       ${StringTools.toDisplayString(currentText)}');
                    }
                    else
                    {
                        logInfo('    availableSpaces <= 0 => cannot not reduce');
                    }
                }
            }
            else
            {
                logInfo('    zero finalIndent');
            }

             currentPos = indentEndPos + Constants.INDENT_END.length;
        }

        final String restText = s.substring(currentPos);
        if (restText.isNotEmpty)
        {
          sb.write(currentText);
          sb.write(restText);
          logInfo('+ rest:                ${StringTools.toDisplayString(currentText + restText)}');
        }

        return sb.toString();
    }

    static String _writeExceptLastLine(StringBuffer sb, String currentLine, String newText, String label)
    {
        logInfo('      writeExceptLastLine($label)');
        logInfo('        currentLine: ${StringTools.toDisplayString(currentLine)}');
        logInfo('        newText:     ${StringTools.toDisplayString(newText)}');

        final int lastLineBreak = newText.lastIndexOf('\n');
        if (lastLineBreak == -1)
        {
            logInfo('        writing:     <nothing>');
            logInfo('        keeping:     ${StringTools.toDisplayString(currentLine + newText)}');
            return currentLine + newText;
        }

        logInfo('+       writing:     ${StringTools.toDisplayString(currentLine + newText.substring(0, lastLineBreak + 1))}');
        logInfo('        keeping:     ${StringTools.toDisplayString(newText.substring(lastLineBreak + 1))}');
        sb.write(currentLine + newText.substring(0, lastLineBreak + 1));
        return newText.substring(lastLineBreak + 1);
    }
}
