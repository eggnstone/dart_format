// ignore_for_file: always_put_control_body_on_new_line

import 'Constants/Constants.dart';
import 'Data/TextInfo.dart';
import 'Exceptions/DartFormatException.dart';
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

        /*if (!isRaw && !s.startsWith(startMarker))
            throw DartFormatException.error('Does not start with expected start marker: ${StringTools.toDisplayString(s)}');

        if (isRaw && !s.startsWith('r$startMarker'))
            throw DartFormatException.error('Does not start with expected start marker: r${StringTools.toDisplayString(s)}');*/

        int depth = 1;
        int currentPos = startMarker.length;
        while (currentPos < s.length)
        {
            final int endMarkerPos = s.indexOf(endMarker, currentPos);
            if (endMarkerPos == -1)
            {
                if (forceClosed)
                    throw DartFormatException.error('No end marker found: ${StringTools.toDisplayString(s)}');

                if (Constants.DEBUG_TEXT_EXTRACTOR) logInternal('${spacer}  No end marker found => Returning all');
                return TextInfo(type: type, text: s);
            }

            final int start2MarkerPos = allowNested ? s.indexOf(startMarker, currentPos) : -1;
            final int escapePos = isRaw ? -1 : s.indexOf(r'\', currentPos);
            if (Constants.DEBUG_TEXT_EXTRACTOR)
            {
                logInternal('${spacer}  escapePos:       $escapePos');
                logInternal('${spacer}  start2MarkerPos: $start2MarkerPos');
                logInternal('${spacer}  endMarkerPos:    $endMarkerPos');
            }

            if (_isFirst(escapePos, endMarkerPos, start2MarkerPos))
            {
                if (Constants.DEBUG_TEXT_EXTRACTOR) logInternal('${spacer}  Skipping escaped marker at $escapePos: ${StringTools.toDisplayString(s.substring(escapePos, escapePos + 2))}');
                currentPos = escapePos + 2;
                continue;
            }

            if (_isFirst(start2MarkerPos, endMarkerPos, escapePos))
            {
                if (Constants.DEBUG_TEXT_EXTRACTOR) logInternal('${spacer}  Increasing depth at $start2MarkerPos');
                depth++;
                currentPos = start2MarkerPos + startMarker.length;
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

    static bool _isFirst(int main, int other1, int other2)
    {
        if (main == -1)
            return false;

        if (other1 != -1 && other1 < main)
            return false;

        if (other2 != -1 && other2 < main)
            return false;

        return true;
    }
}
