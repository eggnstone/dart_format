void f()
{
    final  (Span, Span?)? merged = _tryMergeAdjacent(pending, next, softHyphenCharCode, language, pageIndex, blockIndex);
}

/*
should be

void f()
{
    final (Span, Span?)? merged = _tryMergeAdjacent(pending, next, softHyphenCharCode, language, pageIndex, blockIndex);
}
*/
