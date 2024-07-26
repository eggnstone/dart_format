import 'Data/TextInfo.dart';
import 'Tools/StringTools.dart';
import 'Types/TextType.dart';

class TextSeparator
{
    static List<TextInfo> separate(String s)
    {
        if (s.isEmpty)
            return <TextInfo>[];

        int currentPos = 0;

        final int? singleQuotePos = StringTools.indexOfOrNull(s, "'", currentPos);
        final int? doubleQuotePos = StringTools.indexOfOrNull(s, '"', currentPos);
        final int? endOfLineCommentStartPos = StringTools.indexOfOrNull(s, '//', currentPos);
        final int? blockCommentStartPos = StringTools.indexOfOrNull(s, '/*', currentPos);

        if (_isFirst(singleQuotePos, doubleQuotePos, blockCommentStartPos, endOfLineCommentStartPos))
            return <TextInfo>[TextInfo(type: TextType.String, text: s)];

        if (_isFirst(doubleQuotePos, singleQuotePos, blockCommentStartPos, endOfLineCommentStartPos))
            return <TextInfo>[TextInfo(type: TextType.String, text: s)];

        if (_isFirst(endOfLineCommentStartPos, singleQuotePos, doubleQuotePos, blockCommentStartPos))
            return <TextInfo>[TextInfo(type: TextType.Comment, text: s)];

        if (_isFirst(blockCommentStartPos, singleQuotePos, doubleQuotePos, endOfLineCommentStartPos))
            return <TextInfo>[TextInfo(type: TextType.Comment, text: s)];



        return <TextInfo>[TextInfo(type: TextType.Normal, text: s)];
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
}
