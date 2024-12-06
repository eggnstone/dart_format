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

    group('TextExtractor.extract default', ()
        {
            test('Empty', ()
                {
                    const String inputText = '';

                    expect(() => TextExtractor.extract(inputText, TextType.Normal, startMarker, endMarker), throwsA(isA<Exception>()));
                }
            );

            test('Unclosed', ()
                {
                    const String inputText = '${startMarker}abc';

                    expect(() => TextExtractor.extract(inputText, TextType.Normal, startMarker, endMarker), throwsA(isA<Exception>()));
                }
            );

            test('Unclosed with escaped end', ()
                {
                    const String inputText = '${startMarker}abc\\$endMarker';

                    expect(() => TextExtractor.extract(inputText, TextType.Normal, startMarker, endMarker), throwsA(isA<Exception>()));
                }
            );

            test('Unclosed with escaped end before something else', ()
                {
                    const String inputText = '${startMarker}abc\\$endMarker something else';

                    expect(() => TextExtractor.extract(inputText, TextType.Normal, startMarker, endMarker), throwsA(isA<Exception>()));
                }
            );

            test('Normal', ()
                {
                    const String inputText = '${startMarker}abc$endMarker';
                    const TextInfo expectedResult = TextInfo(type: TextType.Normal, text: inputText);

                    final TextInfo actualResult = TextExtractor.extract(inputText, TextType.Normal, startMarker, endMarker);

                    expect(actualResult, equals(expectedResult));
                }
            );

            test(r'Normal with $', ()
                {
                    const String inputText = '${startMarker}a\$c$endMarker';
                    const TextInfo expectedResult = TextInfo(type: TextType.Normal, text: inputText);

                    final TextInfo actualResult = TextExtractor.extract(inputText, TextType.Normal, startMarker, endMarker);

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Normal with escaped end', ()
                {
                    const String inputText = '${startMarker}abc\\${endMarker}def$endMarker';
                    const TextInfo expectedResult = TextInfo(type: TextType.Normal, text: inputText);

                    final TextInfo actualResult = TextExtractor.extract(inputText, TextType.Normal, startMarker, endMarker);

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Normal with escaped other', ()
                {
                    const String inputText = '${startMarker}abc\\ndef$endMarker';
                    const TextInfo expectedResult = TextInfo(type: TextType.Normal, text: inputText);

                    final TextInfo actualResult = TextExtractor.extract(inputText, TextType.Normal, startMarker, endMarker);

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Before something else', ()
                {
                    const String inputText = '${startMarker}abc$endMarker something else';
                    const TextInfo expectedResult = TextInfo(type: TextType.Normal, text: '${startMarker}abc$endMarker');

                    final TextInfo actualResult = TextExtractor.extract(inputText, TextType.Normal, startMarker, endMarker);

                    expect(actualResult, equals(expectedResult));
                }
            );
        }
    );
}
