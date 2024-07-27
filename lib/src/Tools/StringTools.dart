// ignore_for_file: always_put_control_body_on_new_line

import '../Data/IntTuple.dart';

class StringTools
{
    static IntTuple findDiff(String s1, String s2)
    {
        int indexInput = 0;
        int indexResult = 0;
        //bool diffFound = false;

        while (true)
        {
            while (indexInput < s1.length && ' \n\r\t'.contains(s1[indexInput]))
                indexInput++;

            while (indexResult < s2.length && ' \n\r\t'.contains(s2[indexResult]))
                indexResult++;

            if (indexInput >= s1.length || indexResult >= s2.length)
                break;

            if (s1[indexInput] != s2[indexResult])
            {
                //diffFound = true;
                break;
            }

            indexInput++;
            indexResult++;
        }

        if (indexInput == s1.length && indexResult == s2.length)
            return createEmptyIntTuple();

        return IntTuple(indexInput, indexResult);
    }

        /*static String _removeLeadingWhitespaceFromNonComment(String s)
        {
            if (Constants.DEBUG_STRING_TOOLS) logInternal('removeLeadingWhitespaceFromNonComment: ${toDisplayString(s)}');

            return '<NON-COMMENT>$s</NON-COMMENT>';
        }*/

        /*static String removeLeadingWhitespaceOld(String s)
        {
            if (Constants.DEBUG_STRING_TOOLS) logInternal('removeLeadingWhitespaceOld: ${toDisplayString(s)}');

          return s.contains('//') || s.contains('/ *')
            ? _removeLeadingWhitespaceWithComments(s)
            : _removeLeadingWhitespaceWithoutComments(s);
        }*/

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

        /*static String _removeLeadingWhitespaceWithComments(String s)
        {
            final StringBuffer sb = StringBuffer();

            if (Constants.DEBUG_STRING_TOOLS)
            {
                logInternal('removeLeadingWhitespaceWithComments');
                logInternal('IN:  ${StringTools.toDisplayString(s)}');
                logInternal('\n-----\n${toDisplayString(s)}\n-----\n$s\n-----');
            }

            String? lastLine;
            int blockCommentStart;
            int curPos = 0;
            while ((blockCommentStart = s.indexOf('/*', curPos)) >= 0)
            {
                final String beforeComment = s.substring(curPos, blockCommentStart);
                if (Constants.DEBUG_STRING_TOOLS) logInfo('beforeComment:   ${toDisplayString(beforeComment)}');

                if (beforeComment.isNotEmpty)
                {
                    final int lastLineBreakPos = beforeComment.lastIndexOf('\n');
                    if (lastLineBreakPos >= 0)
                    {
                        final String lastLineA = beforeComment.substring(0, lastLineBreakPos + 1);
                        if (Constants.DEBUG_STRING_TOOLS) logInfo('lastLine a:      ${toDisplayString(lastLineA)}');

                        final String x = _removeLeadingWhitespaceWithoutComments(lastLineA);
                        if (Constants.DEBUG_STRING_TOOLS) logInfo('x:               ${toDisplayString(x)}');
                        sb.write(x);

                        final String lastLineB = beforeComment.substring(lastLineBreakPos + 1);
                        if (Constants.DEBUG_STRING_TOOLS) logInfo('lastLine b:      ${toDisplayString(lastLineB)}');
                        sb.write(lastLineB);

                        lastLine = lastLineB;
                    }
                    else
                    {
                        final String y = _removeLeadingWhitespaceWithoutComments(beforeComment);
                        if (Constants.DEBUG_STRING_TOOLS) logInfo('y:               ${toDisplayString(y)}');
                        sb.write(y);
                    }
                }
                else
                {
                    if (Constants.DEBUG_STRING_TOOLS) logInfo('beforeComment.isEmpty');
                }

                final int blockCommentEnd = s.indexOf('*/', blockCommentStart);
                if (blockCommentEnd < 0)
                    throw Exception('Block comment not closed.');

                final String comment = s.substring(blockCommentStart, blockCommentEnd + 2);
                if (Constants.DEBUG_STRING_TOOLS) logInfo('comment:         ${toDisplayString(comment)}');
                final String adjustedComment = _removeLeadingWhitespaceFromComment(comment);
                if (Constants.DEBUG_STRING_TOOLS) logInfo('adjustedComment: ${toDisplayString(adjustedComment)}');
                sb.write(adjustedComment);

                curPos = blockCommentEnd + 2;
            }

            final String rest = s.substring(curPos);
            if (Constants.DEBUG_STRING_TOOLS) logInfo('rest:            ${toDisplayString(rest)}');
            if (rest.isNotEmpty)
                sb.write(rest);

            final String result = sb.toString();
            if (Constants.DEBUG_STRING_TOOLS) logInternal('OUT: ${StringTools.toDisplayString(result)}');
            return result;
        }*/

        /*static String _removeLeadingWhitespaceFromComment(String s)
        {
            if (Constants.DEBUG_STRING_TOOLS)
            {
                logInternal('removeLeadingWhitespaceFromComment');
                logInternal('IN:  ${StringTools.toDisplayString(s)}');
            }

            final String result = s.splitMapJoin('\n', onMatch: (Match m) => '${m[0]}                                  ');

            if (Constants.DEBUG_STRING_TOOLS) logInternal('OUT: ${StringTools.toDisplayString(result)}');
            return result;
        }*/

    static int? indexOfOrNull(String s, String pattern, int start)
    {
        final int index = s.indexOf(pattern, start);
        return index < 0 ? null : index;
    }
}
