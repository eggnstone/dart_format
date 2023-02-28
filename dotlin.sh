echo Copying Kotlin code from DartFormatJetBrainsPlugin ...

SOURCE="../../JetBrains/DartFormatJetBrainsPlugin/src/main/kotlin/dev/eggnstone/plugins/jetbrains/dartformat"
DEST="lib/src/kotlin/dev/eggnstone/plugins/jetbrains/dartformat/"

cp -r $SOURCE/dotlin $DEST
cp -r $SOURCE/parts $DEST
cp -r $SOURCE/splitters $DEST

cp -r $SOURCE/Constants.kt $DEST
cp -r $SOURCE/DartFormatException.kt $DEST
cp -r $SOURCE/Indenter.kt $DEST
cp -r $SOURCE/Levels.kt $DEST
cp -r $SOURCE/LevelsCalculator.kt $DEST
cp -r $SOURCE/LineSplitter.kt $DEST
cp -r $SOURCE/Tools.kt $DEST
cp -r $SOURCE/WhitespaceSplitter.kt $DEST

echo Replacing some files ...
cp $DEST/dotlin/DotlinLogger.kt.save $DEST/dotlin/DotlinLogger.kt

echo Executing Dotlin ...
../../../GitHub/dotlin/compiler/build/distributions/dotlin-0.0.1/bin/dotlin

echo Replacing some files ...
cp $DEST/dart_format_exception.dt.g.dart.save $DEST/dart_format_exception.dt.g.dart
cp $DEST/dotlin/dotlin_logger.dt.g.dart.save  $DEST/dotlin/dotlin_logger.dt.g.dart
mv $DEST/dotlin/dotlin_tools.dt.g.dart        $DEST/dotlin/dotlin_tools.dt.g.dart.old

echo Adding imports ...
#echo 'import "../StringExtensions.dart";' | cat - $DEST/dotlin/dotlin_tools.dt.g.dart.old > $DEST/dotlin/dotlin_tools.dt.g.dart

#./FixIsEmpty.sh
