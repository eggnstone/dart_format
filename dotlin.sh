echo Copying Kotlin code from DartFormatJetBrainsPlugin ...
cp -r ../../JetBrains/DartFormatJetBrainsPlugin/src/main/kotlin/com/eggnstone/jetbrainsplugins/dartformat/dotlin/C.kt lib/src/kotlin/dotlin
# do not copy DotlinLogger.kt
cp -r ../../JetBrains/DartFormatJetBrainsPlugin/src/main/kotlin/com/eggnstone/jetbrainsplugins/dartformat/dotlin/DotlinTools.kt lib/src/kotlin/dotlin

cp -r ../../JetBrains/DartFormatJetBrainsPlugin/src/main/kotlin/com/eggnstone/jetbrainsplugins/dartformat/simple_blockifier lib/src/kotlin
cp -r ../../JetBrains/DartFormatJetBrainsPlugin/src/main/kotlin/com/eggnstone/jetbrainsplugins/dartformat/simple_blocks lib/src/kotlin

cp -r ../../JetBrains/DartFormatJetBrainsPlugin/src/main/kotlin/com/eggnstone/jetbrainsplugins/dartformat/Constants.kt lib/src/kotlin
cp -r ../../JetBrains/DartFormatJetBrainsPlugin/src/main/kotlin/com/eggnstone/jetbrainsplugins/dartformat/DartFormatException.kt lib/src/kotlin
cp -r ../../JetBrains/DartFormatJetBrainsPlugin/src/main/kotlin/com/eggnstone/jetbrainsplugins/dartformat/Tools.kt lib/src/kotlin

echo Executing Dotlin ...
../../../GitHub/dotlin/compiler/build/distributions/dotlin-0.0.1/bin/dotlin

echo Replacing some files ...
cp lib/src/kotlin/dart_format_exception.dt.g.dart.save lib/src/kotlin/dart_format_exception.dt.g.dart
cp lib/src/kotlin/dotlin/dotlin_logger.dt.g.dart.save lib/src/kotlin/dotlin/dotlin_logger.dt.g.dart

./FixPaths.sh
./FixIsEmpty.sh

echo Some more fixes ...
mv lib/src/kotlin/dotlin/dotlin_tools.dt.g.dart lib/src/kotlin/dotlin/dotlin_tools.dt.g.dart.old
mv lib/src/kotlin/simple_blockifier/simple_blockifier.dt.g.dart lib/src/kotlin/simple_blockifier/simple_blockifier.dt.g.dart.old

echo 'import "../StringExtensions.dart";' | cat - lib/src/kotlin/dotlin/dotlin_tools.dt.g.dart.old > lib/src/kotlin/dotlin/dotlin_tools.dt.g.dart
echo 'import "../StringExtensions.dart";' | cat - lib/src/kotlin/simple_blockifier/simple_blockifier.dt.g.dart.old > lib/src/kotlin/simple_blockifier/simple_blockifier.dt.g.dart
