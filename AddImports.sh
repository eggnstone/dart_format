#!/bin/sh

DEST="lib/src/kotlin/dev/eggnstone/plugins/jetbrains/dartformat"

echo Adding imports ...

mv $DEST/dotlin/dotlin_tools.dt.g.dart        $DEST/dotlin/dotlin_tools.dt.g.dart.old &&
  echo 'import "../StringExtensions.dart";' | cat - $DEST/dotlin/dotlin_tools.dt.g.dart.old > $DEST/dotlin/dotlin_tools.dt.g.dart

mv $DEST/extractors/comment_extractor.dt.g.dart        $DEST/extractors/comment_extractor.dt.g.dart.old &&
  echo 'import "../StringExtensions.dart";' | cat - $DEST/extractors/comment_extractor.dt.g.dart.old > $DEST/extractors/comment_extractor.dt.g.dart

mv $DEST/splitters/iSplitters/master_splitter.dt.g.dart        $DEST/splitters/iSplitters/master_splitter.dt.g.dart.old &&
  echo 'import "../../StringExtensions.dart";' | cat - $DEST/splitters/iSplitters/master_splitter.dt.g.dart.old > $DEST/splitters/iSplitters/master_splitter.dt.g.dart

mv $DEST/splitters/iSplitters/text_splitter.dt.g.dart        $DEST/splitters/iSplitters/text_splitter.dt.g.dart.old &&
  echo 'import "../../StringExtensions.dart";' | cat - $DEST/splitters/iSplitters/text_splitter.dt.g.dart.old > $DEST/splitters/iSplitters/text_splitter.dt.g.dart

mv $DEST/splitters/iSplitters/whitespace_splitter.dt.g.dart        $DEST/splitters/iSplitters/whitespace_splitter.dt.g.dart.old &&
  echo 'import "../../StringExtensions.dart";' | cat - $DEST/splitters/iSplitters/whitespace_splitter.dt.g.dart.old > $DEST/splitters/iSplitters/whitespace_splitter.dt.g.dart

mv $DEST/tools.dt.g.dart        $DEST/tools.dt.g.dart.old &&
  echo 'import "StringExtensions.dart";' | cat - $DEST/tools.dt.g.dart.old > $DEST/tools.dt.g.dart
