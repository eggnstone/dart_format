// ignore_for_file: always_put_control_body_on_new_line

import '../../dart_format.dart';
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

    static StringBuffer _removeLeadingWhitespaceInCode(String s)
    {
        if (Constants.DEBUG_STRING_TOOLS_REMOVE_LEADING_WHITESPACE)
        {
            logInternal('  _removeLeadingWhitespaceInCode:            ${StringTools.toDisplayString(s)}');
            logInternal('    IN:  ${StringTools.toDisplayString(s)}');
        }

        final List<String> lines = s.split('\n');
        if (lines.length < 2)
        {
            if (Constants.DEBUG_STRING_TOOLS_REMOVE_LEADING_WHITESPACE) logInternal('    OUT: ${StringTools.toDisplayString(s)}');
            return StringBuffer(s);
        }

        final StringBuffer sb = StringBuffer();

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

        if (Constants.DEBUG_STRING_TOOLS_REMOVE_LEADING_WHITESPACE) logInternal('    OUT: ${StringTools.toDisplayString(sb.toString())}');
        return sb;
    }

    static StringBuffer _removeLeadingWhitespaceInBlockComment(String s)
    {
        if (Constants.DEBUG_STRING_TOOLS_REMOVE_LEADING_WHITESPACE)
        {
            logInternal('  _removeLeadingWhitespaceInBlockComment:    ${StringTools.toDisplayString(s)}');
            logInternal('    IN:  ${StringTools.toDisplayString(s)}');
        }

        final List<String> lines = s.split('\n');
        if (lines.length < 2)
        {
            if (Constants.DEBUG_STRING_TOOLS_REMOVE_LEADING_WHITESPACE) logInternal('    OUT: ${StringTools.toDisplayString(s)}');
            return StringBuffer(s);
        }

        final StringBuffer sb = StringBuffer();

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
            minIndentation = 0;

        //if (Constants.DEBUG_STRING_TOOLS) logInternal('minIndentation: $minIndentation');

        for (int i = 0; i < lines.length; i++)
        {
            final String line = lines[i];
            //if (Constants.DEBUG_STRING_TOOLS) logInternal('>   #$i: ${StringTools.toDisplayString(line)}');

            if (i == 0)
            {
                sb.write(line);
                //if (Constants.DEBUG_STRING_TOOLS) logInternal('<   #$i: ${StringTools.toDisplayString(line)}');
            }
            else
            {
                sb.write('\n');
                //if (Constants.DEBUG_STRING_TOOLS) logInternal('<   #$i: \\n');
                final String shortenedLine = line.length <= minIndentation ? '' : line.substring(minIndentation);
                sb.write(shortenedLine);
                //if (Constants.DEBUG_STRING_TOOLS) logInternal('<   #$i: ${StringTools.toDisplayString(shortenedLine)}');
            }
        }

        if (Constants.DEBUG_STRING_TOOLS_REMOVE_LEADING_WHITESPACE) logInternal('    OUT: ${StringTools.toDisplayString(sb.toString())}');
        return sb;
    }

    static String removeLeadingWhitespace(String s, {
            bool expectComments = false,
            int position = -1,
            String source = 'TEST',
            String Function(int offset)? onGetPositionInfo
        })
    {
        if (Constants.DEBUG_STRING_TOOLS_REMOVE_LEADING_WHITESPACE)
        {
            logInternal('removeLeadingWhitespace(expectComments=$expectComments, $source)');
            logInternal('IN:  ${StringTools.toDisplayString(s)}');
        }

        if (!expectComments)
            return _removeLeadingWhitespaceInCode(s).toString();

        if (Constants.DEBUG_STRING_TOOLS_REMOVE_LEADING_WHITESPACE)
        {
            splitBlockCommentsAndJoin(s,
                onMatch:  (String s)
                {
                    logInternal('  COMMENT:     ${StringTools.toDisplayString(s)}');
                    return StringBuffer();
                }
                ,
                onNonMatch: (String s)
                {
                    logInternal('  NON-COMMENT: ${StringTools.toDisplayString(s)}');
                    return StringBuffer();
                }
            );
        }

        final String fixedS = splitBlockCommentsAndJoin(s,
            onMatch:  _removeLeadingWhitespaceInBlockComment,
            onNonMatch: _removeLeadingWhitespaceInCode,
            position: position,
            onGetPositionInfo: onGetPositionInfo
        );

        if (Constants.DEBUG_STRING_TOOLS_REMOVE_LEADING_WHITESPACE) logInternal('OUT: ${StringTools.toDisplayString(fixedS)}');
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

    static String splitBlockCommentsAndJoin(String s, {
            required StringBuffer Function(String s) onMatch, 
            required StringBuffer Function(String s) onNonMatch,
            int position = -1,
            String Function(int offset)? onGetPositionInfo
        })
    {
        if (s.isEmpty)
            return s;

        if (Constants.DEBUG_STRING_TOOLS_SPLIT_BLOCK_COMMENTS_AND_JOIN)
            logInternal('# splitBlockCommentsAndJoin: ${toDisplayString(s)}');

        final StringBuffer sb = StringBuffer();
        final StringBuffer currentBlock = StringBuffer();
        int commentDepth = 0;
        for (int i = 0; i < s.length; i++)
        {
            if (s[i] == '/' && i + 1 < s.length && s[i + 1] == '*')
            {
                if (Constants.DEBUG_STRING_TOOLS_SPLIT_BLOCK_COMMENTS_AND_JOIN)
                    logInternal('  $i: Start of block comment found: ${toDisplayString(s.substring(i))}');

                if (commentDepth == 0 && currentBlock.isNotEmpty)
                {
                    sb.write(onNonMatch(currentBlock.toString()));
                    currentBlock.clear();
                }

                currentBlock.write('/*');
                commentDepth++;
                i++;
                continue;
            }

            if (s[i] == '*' && i + 1 < s.length && s[i + 1] == '/')
            {
                if (Constants.DEBUG_STRING_TOOLS_SPLIT_BLOCK_COMMENTS_AND_JOIN)
                    logInternal('  $i: End of block comment found: ${toDisplayString(s.substring(i))}');

                if (commentDepth <= 0)
                {
                    String positionInfo = '';
                    if (position >= 0 && onGetPositionInfo != null)
                        positionInfo = ' at ${onGetPositionInfo.call(position)}';
                    throw DartFormatException.error(
                        'Unbalanced block comments:'
                        ' Found end of block comment without start of block comment'
                        ' commentDepth ($commentDepth) <= 0'
                        '$positionInfo'
                        ' ${toDisplayString(s)}');
                }

                currentBlock.write('*/');
                commentDepth--;
                i++;

                if (commentDepth == 0 && currentBlock.isNotEmpty)
                {
                    sb.write(onMatch(currentBlock.toString()));
                    currentBlock.clear();
                }

                continue;
            }

            currentBlock.write(s[i]);
        }

        if (commentDepth > 0)
        {
            String positionInfo = '';
            if (position >= 0 && onGetPositionInfo != null)
                positionInfo = ' at ${onGetPositionInfo.call(position)}';
            throw DartFormatException.error(
                'Unbalanced block comments:'
                ' Did not find end of block comment for start of block comment'
                ' commentDepth ($commentDepth) > 0'
                '$positionInfo'
                ' ${toDisplayString(s)}');
        }

        if (currentBlock.isNotEmpty)
            sb.write(onNonMatch(currentBlock.toString()));

        return sb.toString();
    }
}
