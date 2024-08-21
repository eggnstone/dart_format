// ignore_for_file: always_put_control_body_on_new_line

import '../Data/IntTuple.dart';

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

    static int? indexOfOrNull(String s, Pattern pattern, int start, {required bool handleEscape})
    {
        final int index = s.indexOf(pattern, start);
        if (handleEscape && index > 0 && s[index - 1] == r'\')
            return indexOfOrNull(s, pattern, index + 1, handleEscape: true);

        return index < 0 ? null : index;
    }

    static String padIntLeft(int i, int length) => i.toString().padLeft(length);

    static String padIntLeft0(int i, int length) => i.toString().padLeft(length, '0');

    static String removeTrailingSpaces(String s)
    {
        if (s.isEmpty)
            return s;

        int pos = s.length;
        while (pos > 0 && s[pos - 1] == ' ')
            pos--;

        return s.substring(0, pos);
    }

    static String shorten50(String s)
    => shorten(s, 50);

    static String shorten(String s, int maxLength)
    => s.length <= maxLength ? s : s.substring(0, maxLength);

    static String toDisplayString(Object? o, [int maxLength = -1])
    => '"${toSafeString(o, maxLength)}"';

    static String toDisplayStringCutAtFront(Object? o, [int maxLength = -1])
    {
        if (o == null)
            return '<null>';

        final String s = o.toString();

        String r = s.replaceAll('\n', r'\n').replaceAll('\r', r'\r').replaceAll('\t', r'\t');
        if (maxLength >= 0 && r.length > maxLength)
            r = '...${r.substring(r.length - maxLength)}';

        return '"$r"';
    }

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

    static String trimEndExceptNewLines(String s)
    {
        String r = s;

        while (r.endsWith('\n'))
            r = r.substring(0, r.length - 1);

        return r;
    }
}
