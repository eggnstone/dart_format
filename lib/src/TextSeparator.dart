// ignore_for_file: always_put_control_body_on_new_line

import 'Constants/Constants.dart';
import 'Constants/TextConstants.dart';
import 'Data/TextInfo.dart';
import 'FindStartTextResult.dart';
import 'TextExtractor.dart';
import 'TextFinder.dart';
import 'Tools/LogTools.dart';
import 'Tools/StringTools.dart';
import 'Types/TextType.dart';

class TextSeparator
{
    static List<TextInfo> separate(String s, String spacer)
    {
        if (s.isEmpty)
            return <TextInfo>[];

        final List<TextInfo> result = <TextInfo>[];

        if (Constants.DEBUG_TEXT_SEPARATOR) logInternal('${spacer}TextSeparator.separate: ${StringTools.toDisplayString(s)}');

        int currentPos = 0;
        while (currentPos < s.length)
        {
            if (Constants.DEBUG_TEXT_SEPARATOR)
            {
                logInternal('$spacer  CurrentPos: $currentPos');
                logInternal('$spacer  Rest:       ${StringTools.toDisplayString(s.substring(currentPos))}');
            }

            final FindStartTextResult startInfo = TextFinder.findStart(s, currentPos, '$spacer    ');
            final int? first = startInfo.getFirst();
            if (first != null)
            {
                if (first > currentPos)
                {
                    final TextInfo info = TextInfo(type: TextType.Normal, text: s.substring(currentPos, first));
                    if (Constants.DEBUG_TEXT_SEPARATOR) logInternal('$spacer    Found: ${info.type} ${StringTools.toDisplayString(info.text)}');
                    result.add(info);
                    currentPos += info.text.length;
                }

                if (startInfo.endOfLineCommentStartPos == first)
                {
                    final TextInfo info = TextExtractor.extract(s.substring(startInfo.endOfLineCommentStartPos!), TextType.Comment, TextConstants.END_OF_LINE_COMMENT_START, TextConstants.END_OF_LINE_COMMENT_END, forceClosed: false, spacer: '$spacer  ');
                    if (Constants.DEBUG_TEXT_SEPARATOR) logInternal('$spacer    Found: ${info.type} ${StringTools.toDisplayString(info.text)}');
                    result.add(info);
                    currentPos += info.text.length;
                    continue;
                }

                if (startInfo.blockCommentStartPos == first)
                {
                    final TextInfo info = TextExtractor.extract(s.substring(startInfo.blockCommentStartPos!), TextType.Comment, TextConstants.BLOCK_COMMENT_START, TextConstants.BLOCK_COMMENT_END, allowNested: true, spacer: '$spacer  ');
                    if (Constants.DEBUG_TEXT_SEPARATOR) logInternal('$spacer    Found: ${info.type} ${StringTools.toDisplayString(info.text)}');
                    result.add(info);
                    currentPos += info.text.length;
                    continue;
                }
            }

            final TextInfo info = TextInfo(type: TextType.Normal, text: s.substring(currentPos));
            if (Constants.DEBUG_TEXT_SEPARATOR) logInternal('$spacer    Found: ${info.type} ${StringTools.toDisplayString(info.text)}');
            result.add(info);
            break;
        }

        return result;
    }
}
