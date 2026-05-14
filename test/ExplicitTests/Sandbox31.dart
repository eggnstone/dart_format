void f()
{
    if (message is!({String bookFilePath, String coverFilePath, String coverColorFilePath}))
        ;

    final (Span, Span?)? merged = _tryMergeAdjacent(pending, next, softHyphenCharCode, language, pageIndex, blockIndex);
}

/*
should be

void f()
{
    if (message is! ({String bookFilePath, String coverFilePath, String coverColorFilePath}))
        ;

    final (Span, Span?)? merged = _tryMergeAdjacent(pending, next, softHyphenCharCode, language, pageIndex, blockIndex);
}
*/
