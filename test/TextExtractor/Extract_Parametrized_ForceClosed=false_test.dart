import 'package:dart_format/src/Data/TextInfo.dart';
import 'package:dart_format/src/Data/Tuple.dart';
import 'package:dart_format/src/TextExtractor.dart';
import 'package:dart_format/src/Types/TextType.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('TextExtractor.extract forceClose=false', ()
    {
        final Map<String, Tuple<String, String>> params = <String, Tuple<String, String>>
        {
            'A-X unclosed ok': const Tuple<String, String>('A', 'X'),
            'A-XYZ unclosed ok': const Tuple<String, String>('A', 'XYZ'),
            'ABC-X unclosed ok': const Tuple<String, String>('ABC', 'X'),
            'ABC-XYZ unclosed ok': const Tuple<String, String>('ABC', 'XYZ'),
            '//': const Tuple<String, String>('//', '\n'),
        };

        params.forEach((String name, Tuple<String, String> markers) {
            group(name, () {
                test('Empty', () {
                    const String inputText = '';

                    expect(() => TextExtractor.extract(inputText, TextType.Normal, markers.item1, markers.item2, forceClosed: false), throwsA(isA<Exception>()));
                }
                );

                test('Unclosed', () {
                    final String inputText = '${markers.item1}abc';
                    final TextInfo expectedResult = TextInfo(type: TextType.Normal, text: inputText);

                        final TextInfo actualResult = TextExtractor.extract(inputText, TextType.Normal, markers.item1, markers.item2, forceClosed: false);

                        expect(actualResult, equals(expectedResult));
        }
                );

                test('Unclosed with escaped end', () {
                    final String inputText = '${markers.item1}abc\\${markers.item2}';

                    expect(() => TextExtractor.extract(inputText, TextType.Normal, markers.item1, markers.item2, forceClosed: false), throwsA(isA<Exception>()));
                }
                );

                test('Normal', () {
                    final String inputText = '${markers.item1}abc${markers.item2}';
                    final String expectedText = '${markers.item1}abc';
                    final TextInfo expectedResult = TextInfo(type: TextType.Normal, text: expectedText);

                    final TextInfo actualResult = TextExtractor.extract(inputText, TextType.Normal, markers.item1, markers.item2, forceClosed: false);

                    expect(actualResult, equals(expectedResult));
                }
                );

                test('Normal with escaped end', () {
                    final String inputText = '${markers.item1}abc\\${markers.item2}def${markers.item2}';
                    final String expectedText = '${markers.item1}abc\\${markers.item2}def';
                    final TextInfo expectedResult = TextInfo(type: TextType.Normal, text: expectedText);

                    final TextInfo actualResult = TextExtractor.extract(inputText, TextType.Normal, markers.item1, markers.item2, forceClosed: false);

                    expect(actualResult, equals(expectedResult));
                }
                );

                test('Normal with escaped other', () {
                    final String inputText = '${markers.item1}abc\\ndef${markers.item2}';
                    final String expectedText = '${markers.item1}abc\\ndef';
                    final TextInfo expectedResult = TextInfo(type: TextType.Normal, text: expectedText);

                    final TextInfo actualResult = TextExtractor.extract(inputText, TextType.Normal, markers.item1, markers.item2, forceClosed: false);

                    expect(actualResult, equals(expectedResult));
                }
                );

                test('Before something else', () {
                    final String inputText = '${markers.item1}abc${markers.item2} something else';
                    final String expectedText = '${markers.item1}abc';
                    final TextInfo expectedResult = TextInfo(type: TextType.Normal, text: expectedText);

                    final TextInfo actualResult = TextExtractor.extract(inputText, TextType.Normal, markers.item1, markers.item2, forceClosed: false);

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
