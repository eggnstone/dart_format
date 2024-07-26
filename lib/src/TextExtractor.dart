import 'Data/TextInfo.dart';
import 'Exceptions/DartFormatException.dart';
import 'Tools/StringTools.dart';
import 'Types/TextType.dart';

class TextExtractor
{
    static TextInfo extract(String s, TextType type, String startMarker, String endMarker, {bool forceClosed = true})
    {
        int currentPos = startMarker.length;
        while (currentPos < s.length)
        {
            final int escapePos = s.indexOf(r'\', currentPos);
            final int endMarkerPos = s.indexOf(endMarker, currentPos);

            if (escapePos == -1 && endMarkerPos == -1)
            {
                if (forceClosed)
                    throw DartFormatException.error('Unclosed: ${StringTools.toDisplayString(s)}');

                return TextInfo(type: type, text: s);
            }

            if (escapePos >= 0 && escapePos == endMarkerPos - 1)
            {
                currentPos = endMarkerPos + endMarker.length;
                continue;
            }

            if (forceClosed)
                return TextInfo(type: type, text: s.substring(0, endMarkerPos + endMarker.length));

            return TextInfo(type: type, text: s.substring(0, endMarkerPos));
        }

        if (forceClosed)
            throw DartFormatException.error('Unclosed: ${StringTools.toDisplayString(s)}');

        return TextInfo(type: type, text: s);
    }
}
