import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart' as AnalyzerUtilities; // ignore: library_prefixes
import 'package:pub_semver/pub_semver.dart';

class AnalyzerTools
{
    /// Dart language version used for parsing.
    ///
    /// Pinned to the SDK floor declared in pubspec.yaml (`sdk: ^3.10.0`). The
    /// analyzer's default `FeatureSet.latestLanguageVersion()` runs ahead of
    /// stable Dart and rejects valid stable syntax — e.g. `final`/`var`/
    /// `covariant` parameters (`void f(final int x){}`) — so parsing at "latest"
    /// would make the formatter refuse ordinary code. Bump this together with
    /// the analyzer dependency and the pubspec SDK floor.
    static const String LANGUAGE_VERSION = '3.10.0';

    static FeatureSet createFeatureSet()
    => FeatureSet.fromEnableFlags2(sdkLanguageVersion: Version.parse(LANGUAGE_VERSION), flags: const <String>[]);

    static ParseStringResult parseString(String content, {bool throwIfDiagnostics = true})
    => AnalyzerUtilities.parseString(content: content, throwIfDiagnostics: throwIfDiagnostics, featureSet: createFeatureSet());
}
