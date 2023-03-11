#!/bin/sh

echo Copying Kotlin code from DartFormatJetBrainsPlugin ...

SOURCE="../../JetBrains/DartFormatJetBrainsPlugin/src/main/kotlin/dev/eggnstone/plugins/jetbrains/dartformat"
DEST="lib/src/kotlin/dev/eggnstone/plugins/jetbrains/dartformat"

cp -r $SOURCE/dotlin $DEST
cp -r $SOURCE/extractors $DEST
cp -r $SOURCE/indenters $DEST
cp -r $SOURCE/levels $DEST
cp -r $SOURCE/parts $DEST
cp -r $SOURCE/splitters $DEST

#mkdir $DEST/splitters
#cp $SOURCE/splitters/ISplitter.kt $DEST/splitters
#cp $SOURCE/splitters/LineSplitter.kt $DEST/splitters
#cp $SOURCE/splitters/TypeSplitter.kt $DEST/splitters
#cp $SOURCE/splitters/StringSplitter.kt $DEST/splitters
#cp $SOURCE/splitters/SplitType.kt $DEST/splitters
#cp $SOURCE/splitters/SplitResult.kt $DEST/splitters

cp $SOURCE/Constants.kt $DEST
cp $SOURCE/DartFormatException.kt $DEST
cp $SOURCE/Tools.kt $DEST

echo Replacing some files ...
cp $DEST/dotlin/DotlinLogger.kt.save $DEST/dotlin/DotlinLogger.kt

echo Executing Dotlin ...
../../../GitHub/dotlin/compiler/build/distributions/dotlin-0.0.1/bin/dotlin || exit

echo Replacing some files ...
cp $DEST/dart_format_exception.dt.g.dart.save $DEST/dart_format_exception.dt.g.dart
cp $DEST/dotlin/dotlin_logger.dt.g.dart.save  $DEST/dotlin/dotlin_logger.dt.g.dart
mv $DEST/dotlin/dotlin_tools.dt.g.dart        $DEST/dotlin/dotlin_tools.dt.g.dart.old

echo Adding imports ...
echo 'import "../StringExtensions.dart";' | cat - $DEST/dotlin/dotlin_tools.dt.g.dart.old > $DEST/dotlin/dotlin_tools.dt.g.dart
