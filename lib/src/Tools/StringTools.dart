// ignore_for_file: always_put_control_body_on_new_line

import '../Constants/Constants.dart';
import '../Data/IntTuple.dart';
import 'LogTools.dart';

class StringTools
{
    static IntTuple findDiff(String s1, String s2)
    {
        int indexInput = 0;
        int indexResult = 0;

        while (true)
        {
            while (indexInput < s1.length && ' \n\r\t'.contains(s1[indexInput]))
                indexInput++;

            while (indexResult < s2.length && ' \n\r\t'.contains(s2[indexResult]))
                indexResult++;

            if (indexInput >= s1.length || indexResult >= s2.length)
                break;

            if (s1[indexInput] != s2[indexResult])
                break;

            indexInput++;
            indexResult++;
        }

        if (indexInput == s1.length && indexResult == s2.length)
            return createEmptyIntTuple();

        return IntTuple(indexInput, indexResult);
    }

    static String _removeLeadingWhitespaceNonComment(String s)
    {
        if (Constants.DEBUG_STRING_TOOLS) logInternal('_removeLeadingWhitespaceNonComment: ${StringTools.toDisplayString(s)}');

        final StringBuffer sb = StringBuffer();

        final List<String> lines = s.split('\n');
        if (lines.length < 2)
            return s;

        for (int i = 0; i < lines.length; i++)
        {
            final String line = lines[i];
            //if (Constants.DEBUG_STRING_TOOLS) logInternal('    #$i: ${StringTools.toDisplayString(line)}');

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

        return sb.toString();
    }

    static String _removeLeadingWhitespaceComment(String s)
    {
        if (Constants.DEBUG_STRING_TOOLS) logInternal('_removeLeadingWhitespaceComment:    ${StringTools.toDisplayString(s)}');

        final StringBuffer sb = StringBuffer();

        final List<String> lines = s.split('\n');
        if (lines.length < 2)
            return s;

        int minIndentation = -1;
        // Start at index 1 to skip the first line.
        for (int i = 1; i < lines.length; i++)
        {
            final String line = lines[i];
            if (line.trim().isNotEmpty)
            {
                final int indentation = line.length - line.trimLeft().length;
                if (minIndentation == -1 || indentation < minIndentation)
                    minIndentation = indentation;
            }
        }

        if (minIndentation == -1)
            //return s;
            minIndentation =0;

        if (Constants.DEBUG_STRING_TOOLS) logInternal('minIndentation: $minIndentation');

        for (int i = 0; i < lines.length; i++)
        {
            final String line = lines[i];
            if (Constants.DEBUG_STRING_TOOLS) logInternal('>   #$i: ${StringTools.toDisplayString(line)}');

            if (i == 0)
            {
                sb.write(line);
                if (Constants.DEBUG_STRING_TOOLS) logInternal('<   #$i: ${StringTools.toDisplayString(line)}');
            }
            else
            {
                sb.write('\n');
                if (Constants.DEBUG_STRING_TOOLS) logInternal('<   #$i: \\n');
                final String shortenedLine = line.length <= minIndentation ? '' : line.substring(minIndentation);
                sb.write(shortenedLine);
                if (Constants.DEBUG_STRING_TOOLS) logInternal('<   #$i: ${StringTools.toDisplayString(shortenedLine)}');
            }
        }

        return sb.toString();
    }

    static String removeLeadingWhitespace(String s, [String source = 'TEST'])
    {
        if (Constants.DEBUG_STRING_TOOLS)
        {
            logInternal('removeLeadingWhitespace($source)');
            logInternal('IN:  ${StringTools.toDisplayString(s)}');
        }

        final String fixedS = s.splitMapJoin(
            RegExp(r'/\*.*?\*/', dotAll: true),
            onMatch: (Match m) => _removeLeadingWhitespaceComment(m.group(0)!),
            onNonMatch: _removeLeadingWhitespaceNonComment
        );

        if (Constants.DEBUG_STRING_TOOLS) logInternal('OUT: ${StringTools.toDisplayString(fixedS)}');
        return fixedS;
    }

    static String shorten(String s, int maxLength)
    => s.length <= maxLength ? s : s.substring(0, maxLength);

    static String shorten50(String s)
    => shorten(s, 50);

    //throw UnimplementedError();
    static String toDisplayString(Object? o, [int maxLength = -1])
    => '"${toSafeString(o, maxLength)}"';

    static String toSafeString(Object? o, [int maxLength = -1])
    {
        if (o == null)
            return '<null>';

        final String s = o.toString();

        String r = s.replaceAll('\n', r'\n').replaceAll('\r', r'\r').replaceAll('\t', r'\t');
        if (maxLength >= 0 && r.length > maxLength)
            r = '${r.substring(0, maxLength)}...';

        return r;
    }

    static String toDisplayStringCutAtEnd(Object? o, [int maxLength = -1])
    {
        if (o == null)
            return '<null>';

        final String s = o.toString();

        String r = s.replaceAll('\n', r'\n').replaceAll('\r', r'\r').replaceAll('\t', r'\t');
        if (maxLength >= 0 && r.length > maxLength)
            r = '...${r.substring(r.length - maxLength)}';

        return '"$r"';
    }

    static String trimEndExceptNewLines(String s)
    {
        String r = s;

        while (r.endsWith('\n'))
            r = r.substring(0, r.length - 1);

        return r;
    }
}
