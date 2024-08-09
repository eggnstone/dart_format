import 'TextFinder.dart';

class FindStartTextResult
{
    int? blockCommentStartPos;
    int? doubleQuotePos;
    int? endOfLineCommentStartPos;
    int? rawDoubleQuotePos;
    int? rawSingleQuotePos;
    int? rawTripleDoubleQuotePos;
    int? rawTripleSingleQuotePos;
    int? singleQuotePos;
    int? tripleDoubleQuotePos;
    int? tripleSingleQuotePos;

    int? getFirst()
    => TextFinder.getFirst(<int?>[singleQuotePos, rawSingleQuotePos, doubleQuotePos, rawDoubleQuotePos, endOfLineCommentStartPos, blockCommentStartPos]);
}
