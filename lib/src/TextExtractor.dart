// ignore_for_file: always_put_control_body_on_new_line

import 'Constants/Constants.dart';
import 'Constants/TextConstants.dart';
import 'Data/TextInfo.dart';
import 'Exceptions/DartFormatException.dart';
import 'FindEndTextResult.dart';
import 'TextFinder.dart';
import 'Tools/LogTools.dart';
import 'Tools/StringTools.dart';
import 'Types/TextType.dart';

class TextExtractor
{
    // TODO: rename forceClosed to allowUnclosed?
    static TextInfo extract(String s, TextType type, String startMarker, String endMarker, {bool forceClosed = true, bool allowNested = false, bool isRaw = false, String spacer = ''})
    {
        if (Constants.DEBUG_TEXT_EXTRACTOR) logInternal('${spacer}TextExtractor.extract: ${StringTools.toDisplayString(s)}');

        if (!s.startsWith(startMarker))
            throw DartFormatException.error('Does not start with expected start marker: ${StringTools.toDisplayString(s)}');

        int depth = 1;
        int currentPos = startMarker.length;
        while (currentPos < s.length)
        {
            int currentPos2 = currentPos;
            FindEndTextResult endInfo = TextFinder.findEnd(s, currentPos2, endMarker, isRaw: isRaw, spacer: '$spacer  ');
            while (endInfo.interpolationEndPos != null)
            {
                currentPos2 = endInfo.interpolationEndPos! + TextConstants.INTERPOLATION_END.length;
                endInfo = TextFinder.findEnd(s, currentPos2, endMarker, isRaw: isRaw, spacer: '$spacer    ');
            }

            final int? endMarkerPos = endInfo.endMarkerPos;
            if (Constants.DEBUG_TEXT_EXTRACTOR) logInternal('${spacer}  endMarkerPos: $endMarkerPos');

            if (endMarkerPos == null)
            {
                if (forceClosed)
                    throw DartFormatException.error('No end marker found: ${StringTools.toDisplayString(s)}');

                if (Constants.DEBUG_TEXT_EXTRACTOR) logInternal('${spacer}  No end marker found => Returning all');
                return TextInfo(type: type, text: s);
            }

            final int? start2MarkerPos = allowNested ? StringTools.indexOfOrNull(s, startMarker, currentPos, handleEscape: !isRaw) : null;
            if (Constants.DEBUG_TEXT_EXTRACTOR)
            {
                logInternal('${spacer}  start2MarkerPos: $start2MarkerPos');
                logInternal('${spacer}  endMarkerPos:    $endMarkerPos');
            }

            if (TextFinder.isFirst(start2MarkerPos, <int?>[endMarkerPos]))
            {
                // Start marker 2 is first
                if (Constants.DEBUG_TEXT_EXTRACTOR) logInternal('${spacer}  Increasing depth at $start2MarkerPos');
                depth++;
                currentPos = start2MarkerPos! + startMarker.length;
                continue;
            }

            // End marker is first
            if (Constants.DEBUG_TEXT_EXTRACTOR) logInternal('${spacer}  Handling end marker at $endMarkerPos');

            if (depth > 1)
            {
                depth--;
                currentPos = endMarkerPos + endMarker.length;
                continue;
            }

            if (forceClosed)
            {
                final String resultText = s.substring(0, endMarkerPos + endMarker.length);
                if (Constants.DEBUG_TEXT_EXTRACTOR) logInternal('${spacer}  Returning substring including end marker: ${StringTools.toDisplayString(resultText)}');
                return TextInfo(type: type, text: resultText);
            }

            final String resultText = s.substring(0, endMarkerPos);
            if (Constants.DEBUG_TEXT_EXTRACTOR) logInternal('${spacer}  Returning substring excluding end marker: ${StringTools.toDisplayString(resultText)}');
            return TextInfo(type: type, text: resultText);
        }

        // This can happen when an escaped end marker is found at the very end of the string.

        if (forceClosed)
            throw DartFormatException.error('Only escaped end marker found => unclosed: ${StringTools.toDisplayString(s)}');

        if (Constants.DEBUG_TEXT_EXTRACTOR) logInternal('${spacer}  Only escaped end marker found => Returning all');
        return TextInfo(type: type, text: s);
    }
}
