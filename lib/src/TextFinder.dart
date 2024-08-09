// ignore_for_file: always_put_control_body_on_new_line

import 'Constants/Constants.dart';
import 'Constants/TextConstants.dart';
import 'FindEndTextResult.dart';
import 'FindStartTextResult.dart';
import 'Tools/LogTools.dart';
import 'Tools/StringTools.dart';

class TextFinder
{
    static FindStartTextResult findStart(String s, int startPos, String spacer)
    {
        if (Constants.DEBUG_TEXT_EXTRACTOR) logInternal('${spacer}TextFinder.findStart: ${StringTools.toDisplayString(s)}');

        final FindStartTextResult result = FindStartTextResult();

        result.endOfLineCommentStartPos = StringTools.indexOfOrNull(s, TextConstants.END_OF_LINE_COMMENT_START, startPos, handleEscape: true);
        result.blockCommentStartPos = StringTools.indexOfOrNull(s, TextConstants.BLOCK_COMMENT_START, startPos, handleEscape: true);
        result.singleQuotePos = StringTools.indexOfOrNull(s, TextConstants.SINGLE_QUOTE, startPos, handleEscape: true);
        result.rawSingleQuotePos = StringTools.indexOfOrNull(s, TextConstants.RAW_SINGLE_QUOTE, startPos, handleEscape: true);
        result.doubleQuotePos = StringTools.indexOfOrNull(s, TextConstants.DOUBLE_QUOTE, startPos, handleEscape: true);
        result.rawDoubleQuotePos = StringTools.indexOfOrNull(s, TextConstants.RAW_DOUBLE_QUOTE, startPos, handleEscape: true);
        result.tripleSingleQuotePos = StringTools.indexOfOrNull(s, TextConstants.TRIPLE_SINGLE_QUOTE, startPos, handleEscape: true);
        result.rawTripleSingleQuotePos = StringTools.indexOfOrNull(s, TextConstants.RAW_TRIPLE_SINGLE_QUOTE, startPos, handleEscape: true);
        result.tripleDoubleQuotePos = StringTools.indexOfOrNull(s, TextConstants.TRIPLE_DOUBLE_QUOTE, startPos, handleEscape: true);
        result.rawTripleDoubleQuotePos = StringTools.indexOfOrNull(s, TextConstants.RAW_TRIPLE_DOUBLE_QUOTE, startPos, handleEscape: true);

        if (Constants.DEBUG_TEXT_EXTRACTOR)
        {
            logInternal('${spacer}  endOfLineCommentStartPos: ${result.endOfLineCommentStartPos}');
            logInternal('${spacer}  blockCommentStartPos:     ${result.blockCommentStartPos}');
            logInternal('${spacer}  singleQuotePos:           ${result.singleQuotePos}');
            logInternal('${spacer}  rawSingleQuotePos:        ${result.rawSingleQuotePos}');
            logInternal('${spacer}  doubleQuotePos:           ${result.doubleQuotePos}');
            logInternal('${spacer}  rawDoubleQuotePos:        ${result.rawDoubleQuotePos}');
            logInternal('${spacer}  tripleSingleQuotePos:     ${result.tripleSingleQuotePos}');
            logInternal('${spacer}  rawTripleSingleQuotePos:  ${result.rawTripleSingleQuotePos}');
            logInternal('${spacer}  tripleDoubleQuotePos:     ${result.tripleDoubleQuotePos}');
            logInternal('${spacer}  rawTripleDoubleQuotePos:  ${result.rawTripleDoubleQuotePos}');
        }

        return result;
    }

    static FindEndTextResult findEnd(String s, int startPos, String endMarker, {required bool isRaw, required String spacer})
    {
        if (Constants.DEBUG_TEXT_EXTRACTOR) logInternal('${spacer}TextFinder.findEnd: ${StringTools.toDisplayString(s)}');

        final FindEndTextResult result = FindEndTextResult();

        result.endMarkerPos = StringTools.indexOfOrNull(s, endMarker, startPos, handleEscape: !isRaw);
        if (result.endMarkerPos == null)
            return result;

        if (endMarker != TextConstants.SINGLE_QUOTE
            && endMarker != TextConstants.DOUBLE_QUOTE
            && endMarker != TextConstants.TRIPLE_SINGLE_QUOTE
            && endMarker != TextConstants.TRIPLE_DOUBLE_QUOTE)
            return result;

        result.interpolationStartPos = StringTools.indexOfOrNull(s, TextConstants.INTERPOLATION_START, startPos, handleEscape: !isRaw);
        if (result.interpolationStartPos == null)
            return result;

        result.interpolationEndPos = StringTools.indexOfOrNull(s, TextConstants.INTERPOLATION_END, result.interpolationStartPos! + TextConstants.INTERPOLATION_START.length, handleEscape: !isRaw);

        if (Constants.DEBUG_TEXT_EXTRACTOR)
        {
            logInternal('${spacer}  endMarkerPos:             ${result.endMarkerPos}');
            logInternal('${spacer}  interpolationStartPos:    ${result.interpolationStartPos}');
            logInternal('${spacer}  interpolationEndPos:      ${result.interpolationEndPos}');
        }

        return result;
    }

    static int? getFirst(List<int?> values)
    {
        int? result;

        for (int? value in values)
        {
            if (value == null)
                continue;

            if (result == null || value < result)
                result = value;
        }

        return result;
    }

    static bool isFirst(int? main, List<int?> others)
    {
        if (main == null)
            return false;

        for (int? other in others)
            if (other != null && other < main)
                return false;

        return true;
    }
}
