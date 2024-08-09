// ignore_for_file: always_put_control_body_on_new_line

import 'Constants/Constants.dart';
import 'Data/TextInfo.dart';
import 'TextExtractor.dart';
import 'Tools/LogTools.dart';
import 'Tools/StringTools.dart';
import 'Types/TextType.dart';

class TextSeparator
{
    static const String SINGLE_QUOTE = "'";
    static const String DOUBLE_QUOTE = '"';

    static const String RAW_SINGLE_QUOTE = "r'";
    static const String RAW_DOUBLE_QUOTE = 'r"';

    static const String TRIPLE_SINGLE_QUOTE = "'''";
    static const String TRIPLE_DOUBLE_QUOTE = '"""';

    static const String RAW_TRIPLE_SINGLE_QUOTE = "r'''";
    static const String RAW_TRIPLE_DOUBLE_QUOTE = 'r"""';

    static const String END_OF_LINE_COMMENT_START = '//';
    static const String END_OF_LINE_COMMENT_END = '\n';

    static const String BLOCK_COMMENT_START = '/*';
    static const String BLOCK_COMMENT_END = '*/';

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

            final int? endOfLineCommentStartPos = StringTools.indexOfOrNull(s, END_OF_LINE_COMMENT_START, currentPos);
            final int? blockCommentStartPos = StringTools.indexOfOrNull(s, BLOCK_COMMENT_START, currentPos);
            final int? singleQuotePos = StringTools.indexOfOrNull(s, SINGLE_QUOTE, currentPos);
            final int? rawSingleQuotePos = StringTools.indexOfOrNull(s, RAW_SINGLE_QUOTE, currentPos);
            final int? doubleQuotePos = StringTools.indexOfOrNull(s, DOUBLE_QUOTE, currentPos);
            final int? rawDoubleQuotePos = StringTools.indexOfOrNull(s, RAW_DOUBLE_QUOTE, currentPos);
            final int? tripleSingleQuotePos = StringTools.indexOfOrNull(s, TRIPLE_SINGLE_QUOTE, currentPos);
            final int? rawTripleSingleQuotePos = StringTools.indexOfOrNull(s, RAW_TRIPLE_SINGLE_QUOTE, currentPos);
            final int? tripleDoubleQuotePos = StringTools.indexOfOrNull(s, TRIPLE_DOUBLE_QUOTE, currentPos);
            final int? rawTripleDoubleQuotePos = StringTools.indexOfOrNull(s, RAW_TRIPLE_DOUBLE_QUOTE, currentPos);
            if (Constants.DEBUG_TEXT_EXTRACTOR)
            {
                logInternal('${spacer}    endOfLineCommentStartPos: $endOfLineCommentStartPos');
                logInternal('${spacer}    blockCommentStartPos:     $blockCommentStartPos');
                logInternal('${spacer}    singleQuotePos:           $singleQuotePos');
                logInternal('${spacer}    rawSingleQuotePos:        $rawSingleQuotePos');
                logInternal('${spacer}    doubleQuotePos:           $doubleQuotePos');
                logInternal('${spacer}    rawDoubleQuotePos:        $rawDoubleQuotePos');
                logInternal('${spacer}    tripleSingleQuotePos:     $tripleSingleQuotePos');
                logInternal('${spacer}    rawTripleSingleQuotePos:  $rawTripleSingleQuotePos');
                logInternal('${spacer}    tripleDoubleQuotePos:     $tripleDoubleQuotePos');
                logInternal('${spacer}    rawTripleDoubleQuotePos:  $rawTripleDoubleQuotePos');
            }

            final int? first = _getFirst(<int?>[singleQuotePos, rawSingleQuotePos, doubleQuotePos, rawDoubleQuotePos, endOfLineCommentStartPos, blockCommentStartPos]);
            if (first != null)
            {
                if (first > currentPos)
                {
                    final TextInfo info = TextInfo(type: TextType.Normal, text: s.substring(currentPos, first));
                    if (Constants.DEBUG_TEXT_SEPARATOR) logInternal('$spacer    Found: ${info.type} ${StringTools.toDisplayString(info.text)}');
                    result.add(info);
                    currentPos += info.text.length;
                }

                if (endOfLineCommentStartPos == first)
                {
                    final TextInfo info = TextExtractor.extract(s.substring(endOfLineCommentStartPos!), TextType.Comment, END_OF_LINE_COMMENT_START, END_OF_LINE_COMMENT_END, forceClosed: false, spacer: '$spacer  ');
                    if (Constants.DEBUG_TEXT_SEPARATOR) logInternal('$spacer    Found: ${info.type} ${StringTools.toDisplayString(info.text)}');
                    result.add(info);
                    currentPos += info.text.length;
                    continue;
                }

                if (blockCommentStartPos == first)
                {
                    final TextInfo info = TextExtractor.extract(s.substring(blockCommentStartPos!), TextType.Comment, BLOCK_COMMENT_START, BLOCK_COMMENT_END, allowNested: true, spacer: '$spacer  ');
                    if (Constants.DEBUG_TEXT_SEPARATOR) logInternal('$spacer    Found: ${info.type} ${StringTools.toDisplayString(info.text)}');
                    result.add(info);
                    currentPos += info.text.length;
                    continue;
                }

                // Raw triple quotes before triple quotes

                if (rawTripleSingleQuotePos == first)
                {
                    final TextInfo info = TextExtractor.extract(s.substring(rawTripleSingleQuotePos!), TextType.String, RAW_TRIPLE_SINGLE_QUOTE, TRIPLE_SINGLE_QUOTE, spacer: '$spacer  ', isRaw: true);
                    if (Constants.DEBUG_TEXT_SEPARATOR) logInternal('$spacer    Found: ${info.type} ${StringTools.toDisplayString(info.text)}');
                    result.add(info);
                    currentPos += info.text.length;
                    continue;
                }

                if (rawTripleDoubleQuotePos == first)
                {
                    final TextInfo info = TextExtractor.extract(s.substring(rawTripleDoubleQuotePos!), TextType.String, RAW_TRIPLE_DOUBLE_QUOTE, TRIPLE_DOUBLE_QUOTE, spacer: '$spacer  ', isRaw: true);
                    if (Constants.DEBUG_TEXT_SEPARATOR) logInternal('$spacer    Found: ${info.type} ${StringTools.toDisplayString(info.text)}');
                    result.add(info);
                    currentPos += info.text.length;
                    continue;
                }

                // Triple quotes before quotes

                if (tripleSingleQuotePos == first)
                {
                    final TextInfo info = TextExtractor.extract(s.substring(tripleSingleQuotePos!), TextType.String, TRIPLE_SINGLE_QUOTE, TRIPLE_SINGLE_QUOTE, spacer: '$spacer  ');
                    if (Constants.DEBUG_TEXT_SEPARATOR) logInternal('$spacer    Found: ${info.type} ${StringTools.toDisplayString(info.text)}');
                    result.add(info);
                    currentPos += info.text.length;
                    continue;
                }

                if (tripleDoubleQuotePos == first)
                {
                    final TextInfo info = TextExtractor.extract(s.substring(tripleDoubleQuotePos!), TextType.String, TRIPLE_DOUBLE_QUOTE, TRIPLE_DOUBLE_QUOTE, spacer: '$spacer  ');
                    if (Constants.DEBUG_TEXT_SEPARATOR) logInternal('$spacer    Found: ${info.type} ${StringTools.toDisplayString(info.text)}');
                    result.add(info);
                    currentPos += info.text.length;
                    continue;
                }

                // Raw quotes before quotes

                if (rawSingleQuotePos == first)
                {
                    final TextInfo info = TextExtractor.extract(s.substring(rawSingleQuotePos!), TextType.String, RAW_SINGLE_QUOTE, SINGLE_QUOTE, spacer: '$spacer  ', isRaw: true);
                    if (Constants.DEBUG_TEXT_SEPARATOR) logInternal('$spacer    Found: ${info.type} ${StringTools.toDisplayString(info.text)}');
                    result.add(info);
                    currentPos += info.text.length;
                    continue;
                }

                if (rawDoubleQuotePos == first)
                {
                    final TextInfo info = TextExtractor.extract(s.substring(rawDoubleQuotePos!), TextType.String, RAW_DOUBLE_QUOTE, DOUBLE_QUOTE, spacer: '$spacer  ', isRaw: true);
                    if (Constants.DEBUG_TEXT_SEPARATOR) logInternal('$spacer    Found: ${info.type} ${StringTools.toDisplayString(info.text)}');
                    result.add(info);
                    currentPos += info.text.length;
                    continue;
                }

                // Quotes

                if (singleQuotePos == first)
                {
                    final TextInfo info = TextExtractor.extract(s.substring(singleQuotePos!), TextType.String, SINGLE_QUOTE, SINGLE_QUOTE, spacer: '$spacer  ');
                    if (Constants.DEBUG_TEXT_SEPARATOR) logInternal('$spacer    Found: ${info.type} ${StringTools.toDisplayString(info.text)}');
                    result.add(info);
                    currentPos += info.text.length;
                    continue;
                }

                if (doubleQuotePos == first)
                {
                    final TextInfo info = TextExtractor.extract(s.substring(doubleQuotePos!), TextType.String, DOUBLE_QUOTE, DOUBLE_QUOTE, spacer: '$spacer  ');
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

    static int? _getFirst(List<int?> values)
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
}
