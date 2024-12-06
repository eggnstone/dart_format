// ignore_for_file: always_put_control_body_on_new_line

import '../Data/IntTuple.dart';

class StringTools
{
    static const int Number0 = 48;
    static const int Number9 = 57;
    static const int UpperA = 65;
    static const int UpperZ = 90;
    static const int LowerA = 97;
    static const int LowerZ = 122;

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

    static int countSpacesLeft(String s)
    {
        int count = 0;

        while (count < s.length && s[count] == ' ')
            count++;

        return count;
    }

    static int countSpacesRight(String s)
    {
        int count = 0;

        while (count < s.length && s[s.length - count - 1] == ' ')
            count++;

        return count;
    }

    static String trimSpaces(String s)
    {
        int start = 0;
        while (start < s.length && s[start] == ' ')
            start++;

        int end = s.length;
        while (end > start && s[end - 1] == ' ')
            end--;

        return s.substring(start, end);
    }

    static String condense(String s)
    {
        if (s.isEmpty)
            return s;

        final StringBuffer sb = StringBuffer();

        //String? previousChar;
        bool isPreviousNormal = false;
        //bool isPreviousWhitespace = false;
        //bool isPreviousSpecial = false;
        String? currentChar = s[0];
        bool isCurrentNormal = isNormalChar(currentChar);
        bool isCurrentWhitespace = isWhitespaceChar(currentChar);
        //bool isCurrentSpecial = !isCurrentNormal && !isCurrentWhitespace;

        for (int i = 0; i < s.length; i++)
        {
            final String? nextChar = i + 1 < s.length ? s[i + 1] : null;
            final bool isNextNormal = nextChar != null && isNormalChar(nextChar);
            final bool isNextWhitespace = nextChar != null && isWhitespaceChar(nextChar);
            //final bool isNextSpecial = nextChar == null ? false : !isNextNormal && !isNextWhitespace;

            /*logDebug('current:  ${toDisplayString(currentChar)}${isCurrentNormal ? ' Normal' : ''}${isCurrentWhitespace ? ' Whitespace' : ''}${isCurrentSpecial ? ' Special' : ''}');
            logDebug('  prev:   ${toDisplayString(previousChar)}${isPreviousNormal ? ' Normal' : ''}${isPreviousWhitespace ? ' Whitespace' : ''}${isPreviousSpecial ? ' Special' : ''}');
            logDebug('  next:   ${toDisplayString(nextChar)}${isNextNormal ? ' Normal' : ''}${isNextWhitespace ? ' Whitespace' : ''}${isNextSpecial ? ' Special' : ''}');*/

            if (isCurrentNormal)
            {
                sb.write(currentChar);
            }
            else if (isCurrentWhitespace)
            {
                if (isNextWhitespace)
                {
                    currentChar = nextChar;
                    isCurrentNormal = isNextNormal;
                    isCurrentWhitespace = isNextWhitespace;
                    //isCurrentSpecial = isNextSpecial;
                    continue;
                }

                if (isPreviousNormal && isNextNormal)
                {
                    //logDebug('  Adding space.');
                    sb.write(' ');
                }
            }
            else
            {
                // not normal + not whitespace => special
                sb.write(currentChar);
            }

            //previousChar = currentChar;
            isPreviousNormal = isCurrentNormal;
            //isPreviousWhitespace = isCurrentWhitespace;
            //isPreviousSpecial = isCurrentSpecial;

            currentChar = nextChar;
            isCurrentNormal = isNextNormal;
            isCurrentWhitespace = isNextWhitespace;
            //isCurrentSpecial = isNextSpecial;
        }

        return sb.toString();//.trim();
    }

    static bool isWhitespaceChar(String currentChar) => currentChar == ' ' || currentChar == '\n' || currentChar == '\r' || currentChar == '\t';

    static bool isNormalChar(String currentChar)
    {
        final int currentCharCode = currentChar.codeUnitAt(0);
        //logDebug('isNormalChar: ${toDisplayString(currentChar)}: $currentCharCode');
        return currentCharCode >= LowerA && currentCharCode <= LowerZ || currentCharCode >= UpperA && currentCharCode <= UpperZ || currentCharCode >= Number0 && currentCharCode <= Number9;
    }
}
