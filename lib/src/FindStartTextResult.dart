import 'TextFinder.dart';

class FindStartTextResult
{
    int? blockCommentStartPos;
    int? endOfLineCommentStartPos;

    int? getFirst()
    => TextFinder.getFirst(<int?>[endOfLineCommentStartPos, blockCommentStartPos]);
}
