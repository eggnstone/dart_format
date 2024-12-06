import 'package:dart_format/src/Data/TextInfo.dart';
import 'package:dart_format/src/TextExtractor.dart';
import 'package:dart_format/src/Types/TextType.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    const String startMarker = 'START';
    const String endMarker = 'END';

    TestTools.init();

    group('TextExtractor.extract allow unclosed', ()
        {
            test('Empty', ()
                {
                    const String inputText = '';

                    expect(() => TextExtractor.extract(inputText, TextType.Normal, startMarker, endMarker, forceClosed: false), throwsA(isA<Exception>()));
                }
            );

            test('Unclosed', ()
                {
                    const String inputText = '${startMarker}abc';
                    const TextInfo expectedResult = TextInfo(type: TextType.Normal, text: inputText);

                    final TextInfo actualResult = TextExtractor.extract(inputText, TextType.Normal, startMarker, endMarker, forceClosed: false);

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Unclosed with escaped end 1', ()
                {
                    const String inputText = '${startMarker}abc\\$endMarker';
                    const TextInfo expectedResult = TextInfo(type: TextType.Normal, text: inputText);

                    final TextInfo actualResult = TextExtractor.extract(inputText, TextType.Normal, startMarker, endMarker, forceClosed: false);

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Unclosed with escaped end 2', ()
                {
                    const String inputText = '${startMarker}abc\\${endMarker}def';
                    const TextInfo expectedResult = TextInfo(type: TextType.Normal, text: inputText);

                    final TextInfo actualResult = TextExtractor.extract(inputText, TextType.Normal, startMarker, endMarker, forceClosed: false);

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Normal', ()
                {
                    const String inputText = '${startMarker}abc$endMarker';
                    const String expectedText = '${startMarker}abc';
                    const TextInfo expectedResult = TextInfo(type: TextType.Normal, text: expectedText);

                    final TextInfo actualResult = TextExtractor.extract(inputText, TextType.Normal, startMarker, endMarker, forceClosed: false);

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Normal with escaped end', ()
                {
                    const String inputText = '${startMarker}abc\\${endMarker}def$endMarker';
                    const String expectedText = '${startMarker}abc\\${endMarker}def';
                    const TextInfo expectedResult = TextInfo(type: TextType.Normal, text: expectedText);

                    final TextInfo actualResult = TextExtractor.extract(inputText, TextType.Normal, startMarker, endMarker, forceClosed: false);

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Normal with escaped other', ()
                {
                    const String inputText = '${startMarker}abc\\ndef$endMarker';
                    const String expectedText = '${startMarker}abc\\ndef';
                    const TextInfo expectedResult = TextInfo(type: TextType.Normal, text: expectedText);

                    final TextInfo actualResult = TextExtractor.extract(inputText, TextType.Normal, startMarker, endMarker, forceClosed: false);

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Before something else', ()
                {
                    const String inputText = '${startMarker}abc$endMarker something else';
                    const String expectedText = '${startMarker}abc';
                    const TextInfo expectedResult = TextInfo(type: TextType.Normal, text: expectedText);

                    final TextInfo actualResult = TextExtractor.extract(inputText, TextType.Normal, startMarker, endMarker, forceClosed: false);

                    expect(actualResult, equals(expectedResult));
                }
            );
        }
    );
}
