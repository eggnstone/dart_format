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


    static String removeLeadingWhitespace(String s)
    {
        const String methodName = 'removeLeadingWhitespace';
        final StringBuffer sb = StringBuffer();
        const String spacer = '  ';

        if (Constants.DEBUG_STRING_TOOLS) logInternal('$methodName()\nIN:\n-----\n${toDisplayString(s)}\n-----\n$s\n-----');

        String leading = '';
        int currentPos = 0;
        while (true)
        {
            final int blockCommentStartPos2 = s.indexOf('/*', currentPos);
            final int endOfLineCommentStartPos = s.indexOf('//', currentPos);
            if (blockCommentStartPos2 < 0 && endOfLineCommentStartPos < 0)
                break;

            int commentStartPos;
            int commentEndPos;
            if (blockCommentStartPos2 < 0 || (blockCommentStartPos2 >= 0 && endOfLineCommentStartPos >= 0 && endOfLineCommentStartPos < blockCommentStartPos2))
            {
                // EndOfLine comment comes first
                commentStartPos = endOfLineCommentStartPos;

                final int endOfLineCommentEndPos = s.indexOf('\n', endOfLineCommentStartPos + 2);
                if (endOfLineCommentEndPos < 0)
                {
                    commentEndPos = s.length - 1;
                    //throw DartFormatException.error('TODO: EndOfLine comment 1');
                }
                else
                {
                    commentEndPos = endOfLineCommentEndPos;
                    //throw DartFormatException.error('TODO: EndOfLine comment 2');
                }

                //continue;
            }
            else
            {
                // Block comment comes first
                commentStartPos = blockCommentStartPos2;

                final int blockCommentEndPos = s.indexOf('*/', blockCommentStartPos2 + 2);
                if (blockCommentEndPos < 0)
                    throw DartFormatException.error('Block comment not closed.');

                commentEndPos = blockCommentEndPos + 2;
            }

            final String beforeComment = s.substring(currentPos, commentStartPos);
            if (beforeComment.isNotEmpty)
            {
                final String adjustedNonComment = _removeLeadingWhitespaceFromNonComment(beforeComment, spacer);
                if (Constants.DEBUG_STRING_TOOLS) logInternal('ADDING aNC: ${toDisplayString(adjustedNonComment)}');
                leading = determineLeading(leading, beforeComment, spacer);
                if (leading.isNotEmpty && leading.trim().isEmpty)
                {
                    if (adjustedNonComment.endsWith(leading))
                        sb.write(adjustedNonComment.substring(0, adjustedNonComment.length - leading.length));
                    else
                        sb.write(adjustedNonComment);
                }
                else
                    sb.write(adjustedNonComment);
            }

            final String comment = s.substring(commentStartPos, commentEndPos);
            final String adjustedComment = _removeLeadingWhitespaceFromComment(leading, comment, spacer);
            if (Constants.DEBUG_STRING_TOOLS) logInternal('ADDING aC: ${toDisplayString(adjustedComment)}');
            sb.write(adjustedComment);
            leading = determineLeading(leading, comment, spacer);

            currentPos = commentEndPos;
        }

        final String rest = s.substring(currentPos);
        if (rest.isNotEmpty)
        {
            final String adjustedNonCommentRest = _removeLeadingWhitespaceFromNonComment(rest, spacer);
            if (Constants.DEBUG_STRING_TOOLS) logInternal('adjustedNonCommentRest: ${toDisplayString(adjustedNonCommentRest)}');
            /*if (adjustedNonCommentRest.trim().isEmpty)
            {
                if (Constants.DEBUG_STRING_TOOLS) logInternal('NOT ADDING raNC: ${toDisplayString(adjustedNonCommentRest)}');
            }
            else
            {*/
                if (Constants.DEBUG_STRING_TOOLS) logInternal('ADDING raNC: ${toDisplayString(adjustedNonCommentRest)}');
                sb.write(adjustedNonCommentRest);
            //}
        }

    final String result = sb.toString();
        if (Constants.DEBUG_STRING_TOOLS)
        {
            final String result2 = result
                .replaceAll(Constants.REMOVE_START, '')
                .replaceAll(Constants.REMOVE_END, '');
            logInternal('$methodName()\nOUT:\n-----\n${toDisplayString(result2)}\n-----\n$result2\n-----');
        }

        return result;
            /*.replaceAll('<COMMENT>', '')
            .replaceAll('</COMMENT>', '')
            .replaceAll('<NON-COMMENT>', '')
            .replaceAll('</NON-COMMENT>', '');*/
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

  static String determineLeading(String leading, String s, String spacer)
  {
      final int lastLineBreakPos = s.lastIndexOf('\n');
      if (lastLineBreakPos >= 0)
      {
          final String newLeading = s.substring(lastLineBreakPos + 1);
          if (Constants.DEBUG_STRING_TOOLS) logInternal('${spacer}New leading LB:    ${toDisplayString(newLeading)}');
            return newLeading;
      }

      final String newLeading = leading + s;
      if (Constants.DEBUG_STRING_TOOLS) logInternal('${spacer}New leading No-LB: ${toDisplayString(newLeading)}');
        return newLeading;
  }

    static String _removeLeadingWhitespaceFromNonComment(String s, String spacer)
    {
        final StringBuffer sb = StringBuffer();

        if (Constants.DEBUG_STRING_TOOLS)
        {
            logInternal('${spacer}removeLeadingWhitespaceFromNonComment()');
            logInternal('$spacer  IN:  ${StringTools.toDisplayString(s)}');
        }

        final List<String> lines = s.split('\n');
        for (int i = 0; i < lines.length; i++)
        {
            final String line = lines[i];
            if (Constants.DEBUG_STRING_TOOLS) logInternal('    #${i.toString().padLeft(2, "0")}: ${StringTools.toDisplayString(line)}');

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
        if (Constants.DEBUG_STRING_TOOLS) logInternal('$spacer  OUT: ${StringTools.toDisplayString(result)}');
        return result;
    }

    static String _removeLeadingWhitespaceFromComment(String leading, String s, String spacer)
    {
        if (Constants.DEBUG_STRING_TOOLS)
        {
            logInternal('${spacer}removeLeadingWhitespaceFromComment()');
            logInternal('$spacer  leading: ${toDisplayString(leading)}');
            logInternal('$spacer  s:       ${toDisplayString(s)}');
        }

        return leading.isEmpty ? s : _removeLeadingWhitespaceFromCommentWithLeading(leading, s, '$spacer  ');
    }

    /*static String _removeLeadingWhitespaceFromCommentWithoutLeading(String s)
    {
        if (Constants.DEBUG_STRING_TOOLS) logInternal('removeLeadingWhitespaceFromCommentWithoutLeading: ${toDisplayString(s)}');

        return s.contains('\n')
            ? _removeLeadingWhitespaceFromCommentWithoutLeadingButWithLineBreak(s)
            : _removeLeadingWhitespaceFromCommentWithoutLeadingWithoutLineBreak(s);
    }*/

    /*static String _removeLeadingWhitespaceFromCommentWithoutLeadingWithoutLineBreak(String s)
    {
        if (Constants.DEBUG_STRING_TOOLS) logInternal('removeLeadingWhitespaceFromCommentWithoutLeadingWithoutLineBreak: ${toDisplayString(s)}');
        return s;
    }

    static String _removeLeadingWhitespaceFromCommentWithoutLeadingButWithLineBreak(String s)
    {
        if (Constants.DEBUG_STRING_TOOLS) logInternal('removeLeadingWhitespaceFromCommentWithoutLeadingButWithLineBreak: ${toDisplayString(s)}');
        return s;
        //return '<COMMENT-without-leading-but-with-line-break>$s</COMMENT-without-leading-but-with-line-break>';
    }*/

    static String _removeLeadingWhitespaceFromCommentWithLeading(String leading, String s, String spacer)
    {
        if (Constants.DEBUG_STRING_TOOLS)
        {
            logInternal('${spacer}removeLeadingWhitespaceFromCommentWithLeading()');
            logInternal('$spacer  leading: ${toDisplayString(leading)}');
            logInternal('$spacer  s:       ${toDisplayString(s)}');
        }

        return leading.trim().isEmpty
            ? _removeLeadingWhitespaceFromCommentWithLeadingWhitespace(leading, s, '$spacer  ')
            : _removeLeadingWhitespaceFromCommentWithLeadingText(leading, s, '$spacer  ');
    }

    static String _removeLeadingWhitespaceFromCommentWithLeadingWhitespace(String leadingWhitespace, String s, String spacer)
    {
        if (Constants.DEBUG_STRING_TOOLS)
        {
            logInternal('${spacer}removeLeadingWhitespaceFromCommentWithLeadingWhitespace()');
            logInternal('$spacer  leading: ${toDisplayString(leadingWhitespace)}');
            logInternal('$spacer  s:       ${toDisplayString(s)}');
        }

        int minIndentation = 0;
        final List<String> lines = s.split('\n');
        for (int i = 0; i < lines.length; i++)
        {
            final String line = lines[i];
            int indentation = line.length - line.trimLeft().length;
            if (i == 0)
                indentation += leadingWhitespace.length;

            if (i == 0 || indentation < minIndentation)
                minIndentation = indentation;
        }

        if (Constants.DEBUG_STRING_TOOLS) logInternal('$spacer  minIndentation: $minIndentation');

        final StringBuffer sb = StringBuffer();
        for (int i = 0; i < lines.length; i++)
        {
            final String line = lines[i];
            int indentation = line.length - line.trimLeft().length;
            if (i == 0)
                indentation += leadingWhitespace.length;

            final String newIndentation = ' ' * (indentation - minIndentation);

            if (i > 0)
                sb.write('\n');

            sb.write(newIndentation);
            sb.write(line.trimLeft());
        }

        final String result = sb.toString();
        if (Constants.DEBUG_STRING_TOOLS) logInternal('$spacer  OUT:     ${toDisplayString(result)}');
        return result;
    }

    static String _removeLeadingWhitespaceFromCommentWithLeadingText(String leadingText, String s, String spacer)
    {
        if (Constants.DEBUG_STRING_TOOLS) logInternal('${spacer}removeLeadingWhitespaceFromCommentWithLeadingText: ${toDisplayString(s)}');

        return '<COMMENT-with-leading-text>$s</COMMENT-with-leading-text>';
    }
}
