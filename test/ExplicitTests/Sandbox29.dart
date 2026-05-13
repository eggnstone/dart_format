void f()
{
    result.add(prev.copyWith(
            text: CharInfoConverter.createTextFromCharInfos(mergedCharInfos, softHyphenCharCode: softHyphenCharCode),
            bounds: prev.bounds.expand(span.bounds),
            charInfos: mergedCharInfos
        ));
}

// should be

/*
void f()
{
    result.add(prev.copyWith(
        text: CharInfoConverter.createTextFromCharInfos(mergedCharInfos, softHyphenCharCode: softHyphenCharCode),
        bounds: prev.bounds.expand(span.bounds),
        charInfos: mergedCharInfos
    ));
}
*/
