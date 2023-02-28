import 'package:dart_format/src/kotlin/dev/eggnstone/plugins/jetbrains/dartformat/parts/ipart.dt.g.dart';
import 'package:dart_format/src/kotlin/dev/eggnstone/plugins/jetbrains/dartformat/splitters/mastersplitter.dt.g.dart';
import 'package:test/test.dart';

void main() 
{
    // Actual tests are in https://github.com/eggnstone/DartFormatJetbrainsPlugin
    test('emptyText', ()
    {
        const String inputText = '';
        const List<IPart> expectedParts = <IPart>[];

        final MasterSplitter splitter = MasterSplitter();
        final List<IPart> actualParts = splitter.split(inputText);

        expect(actualParts, equals(expectedParts));
    });
}
