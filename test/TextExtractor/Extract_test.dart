import 'package:dart_format/src/Data/TextInfo.dart';
import 'package:dart_format/src/Data/Triple.dart';
import 'package:dart_format/src/Data/Tuple.dart';
import 'package:dart_format/src/TextExtractor.dart';
import 'package:dart_format/src/Types/TextType.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('TextExtractor.extract with force-close', ()
    {
        final Map<String, Tuple<String, String>> params = <String, Tuple<String, String>>
        {
            'A-X': const Tuple<String, String>('A', 'X'),
            'A-XYZ': const Tuple<String, String>('A', 'XYZ'),
            'ABC-X': const Tuple<String, String>('ABC', 'X'),
            'ABC-XYZ': const Tuple<String, String>('ABC', 'XYZ'),
            "''": const Tuple<String, String>("'", "'"),
            '""': const Tuple<String, String>('"', '"'),
            '/**/': const Tuple<String, String>('/*', '*/')
        };

        params.forEach((String name, Tuple<String, String> markers) {
            group(name, () {
                test('Empty', () {
                    const String inputText = '';

                    expect(() => TextExtractor.extract(inputText, TextType.Normal, markers.item1, markers.item2), throwsA(isA<Exception>()));
                }
                );

                test('Unclosed', () {
                    final String inputText = '${markers.item1}abc';

            expect(() => TextExtractor.extract(inputText, TextType.Normal, markers.item1, markers.item2), throwsA(isA<Exception>()));
        }
                );

                test('Unclosed with escaped end', () {
                    final String inputText = '${markers.item1}abc\\${markers.item2}';

                    expect(() => TextExtractor.extract(inputText, TextType.Normal, markers.item1, markers.item2), throwsA(isA<Exception>()));
                }
                );

                test('Normal', () {
                    final String inputText = '${markers.item1}abc${markers.item2}';
                    final TextInfo expectedResult = TextInfo(type: TextType.Normal, text: inputText);

                    final TextInfo actualResult = TextExtractor.extract(inputText, TextType.Normal, markers.item1, markers.item2);

                    expect(actualResult, equals(expectedResult));
                }
                );

                test('Normal with escaped end', () {
                    final String inputText = '${markers.item1}abc\\${markers.item2}def${markers.item2}';
                    final TextInfo expectedResult = TextInfo(type: TextType.Normal, text: inputText);

                    final TextInfo actualResult = TextExtractor.extract(inputText, TextType.Normal, markers.item1, markers.item2);

                    expect(actualResult, equals(expectedResult));
                }
                );

                test('Normal with escaped other', () {
                    final String inputText = '${markers.item1}abc\\ndef${markers.item2}';
                    final TextInfo expectedResult = TextInfo(type: TextType.Normal, text: inputText);

                    final TextInfo actualResult = TextExtractor.extract(inputText, TextType.Normal, markers.item1, markers.item2);

                    expect(actualResult, equals(expectedResult));
                }
                );

                test('Before something else', () {
                    final String inputText = '${markers.item1}abc${markers.item2} something else';
                    final TextInfo expectedResult = TextInfo(type: TextType.Normal, text: '${markers.item1}abc${markers.item2}');

                    final TextInfo actualResult = TextExtractor.extract(inputText, TextType.Normal, markers.item1, markers.item2);

                    expect(actualResult, equals(expectedResult));
                }
                );
            }
            );
        }
        );
    }
    );
}
