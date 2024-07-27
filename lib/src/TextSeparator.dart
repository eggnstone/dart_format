// ignore_for_file: always_put_control_body_on_new_line

import 'Constants/Constants.dart';
import 'Data/TextInfo.dart';
import 'TextExtractor.dart';
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
            if (Constants.DEBUG_TEXT_SEPARATOR) {
        logInternal('$spacer  CurrentPos: $currentPos');
        logInternal('$spacer  Rest:       ${StringTools.toDisplayString(s.substring(currentPos))}');
      }

      final int? singleQuotePos = StringTools.indexOfOrNull(s, "'", currentPos);
            final int? doubleQuotePos = StringTools.indexOfOrNull(s, '"', currentPos);
            final int? endOfLineCommentStartPos = StringTools.indexOfOrNull(s, '//', currentPos);
            final int? blockCommentStartPos = StringTools.indexOfOrNull(s, '/*', currentPos);

            final int? first = _getFirst(singleQuotePos, doubleQuotePos, endOfLineCommentStartPos, blockCommentStartPos);
            if (first != null && first > currentPos)
            {
                final TextInfo info = TextInfo(type: TextType.Normal, text: s.substring(currentPos, first));
                if (Constants.DEBUG_TEXT_SEPARATOR) logInternal('$spacer    Found: ${info.type} ${StringTools.toDisplayString(info.text)}');
                result.add(info);
                currentPos += info.text.length;
            }

            if (_isFirst(singleQuotePos, doubleQuotePos, blockCommentStartPos, endOfLineCommentStartPos))
            {
                final TextInfo info = TextExtractor.extract(s.substring(singleQuotePos!), TextType.String, "'", "'", spacer: '$spacer  ');
                if (Constants.DEBUG_TEXT_SEPARATOR) logInternal('$spacer    Found: ${info.type} ${StringTools.toDisplayString(info.text)}');
                result.add(info);
                currentPos += info.text.length;
                continue;
            }

            if (_isFirst(doubleQuotePos, singleQuotePos, blockCommentStartPos, endOfLineCommentStartPos))
            {
                final TextInfo info = TextExtractor.extract(s.substring(doubleQuotePos!), TextType.String, '"', '"', spacer: '$spacer  ');
                if (Constants.DEBUG_TEXT_SEPARATOR) logInternal('$spacer    Found: ${info.type} ${StringTools.toDisplayString(info.text)}');
                result.add(info);
                currentPos += info.text.length;
                continue;
            }

            if (_isFirst(endOfLineCommentStartPos, singleQuotePos, doubleQuotePos, blockCommentStartPos))
            {
                final TextInfo info = TextExtractor.extract(s.substring(endOfLineCommentStartPos!), TextType.Comment, '//', '\n', forceClosed: false, spacer: '$spacer  ');
                if (Constants.DEBUG_TEXT_SEPARATOR) logInternal('$spacer    Found: ${info.type} ${StringTools.toDisplayString(info.text)}');
                result.add(info);
                currentPos += info.text.length;
                continue;
            }

            if (_isFirst(blockCommentStartPos, singleQuotePos, doubleQuotePos, endOfLineCommentStartPos))
            {
                final TextInfo info = TextExtractor.extract(s.substring(blockCommentStartPos!), TextType.Comment, '/*', '*/', allowNested: true, spacer: '$spacer  ');
                if (Constants.DEBUG_TEXT_SEPARATOR) logInternal('$spacer    Found: ${info.type} ${StringTools.toDisplayString(info.text)}');
                result.add(info);
                currentPos += info.text.length;
                continue;
            }

            final TextInfo info = TextInfo(type: TextType.Normal, text: s.substring(currentPos));
            if (Constants.DEBUG_TEXT_SEPARATOR) logInternal('$spacer    Found: ${info.type} ${StringTools.toDisplayString(info.text)}');
            result.add(info);
            break;
        }

        return result;
    }

  static bool _isFirst(int? main, int? other1, int? other2, int? other3)
  {
        if (main == null)
            return false;

        if (other1 != null && other1 < main)
            return false;

        if (other2 != null && other2 < main)
            return false;

        if (other3 != null && other3 < main)
            return false;

        return true;
  }

  static int? _getFirst(int? i1,     int? i2,     int? i3,     int? i4)
  {
      int? result;

        if (i1 != null)
            result = i1;

        if (i2 != null && (result == null || i2 < result))
            result = i2;

        if (i3 != null && (result == null || i3 < result))
            result = i3;

        if (i4 != null && (result == null || i4 < result))
            result = i4;

      return result;
    }
}
