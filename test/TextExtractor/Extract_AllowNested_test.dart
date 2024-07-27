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

    group('TextExtractor.extract allow nested', ()
        {
            test('Empty', ()
                {
                    const String inputText = '';

                    expect(() => TextExtractor.extract(inputText, TextType.Normal, startMarker, endMarker, allowNested: true), throwsA(isA<Exception>()));
                }
            );

            test('Normal', ()
                {
                    const String inputText = '${startMarker}a${endMarker}';
                    const TextInfo expectedResult = TextInfo(type: TextType.Normal, text: inputText);

                    final TextInfo actualResult = TextExtractor.extract(inputText, TextType.Normal, startMarker, endMarker, allowNested: true);

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Nested', ()
                {
                    const String inputText = '${startMarker}a${startMarker}b${endMarker}c${endMarker}';
                    const TextInfo expectedResult = TextInfo(type: TextType.Normal, text: inputText);

                    final TextInfo actualResult = TextExtractor.extract(inputText, TextType.Normal, startMarker, endMarker, allowNested: true);

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Nested with escaped second starter', ()
                {
                    const String inputText = '${startMarker}a\\${startMarker}b${endMarker}';
                    const TextInfo expectedResult = TextInfo(type: TextType.Normal, text: inputText);

                    final TextInfo actualResult = TextExtractor.extract(inputText, TextType.Normal, startMarker, endMarker, allowNested: true);

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Nested with escaped first finisher', ()
                {
                    const String inputText = '${startMarker}a${startMarker}b\\${endMarker}c${endMarker}d${endMarker}';
                    const TextInfo expectedResult = TextInfo(type: TextType.Normal, text: inputText);

                    final TextInfo actualResult = TextExtractor.extract(inputText, TextType.Normal, startMarker, endMarker, allowNested: true);

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Nested with escaped first finisher, unclosed', ()
                {
                    const String inputText = '${startMarker}a${startMarker}b\\${endMarker}c${endMarker}';

                    expect(() => TextExtractor.extract(inputText, TextType.Normal, startMarker, endMarker, allowNested: true), throwsA(isA<Exception>()));
                }
            );

            test('Nested with escaped second finisher', ()
                {
                    const String inputText = '${startMarker}a${startMarker}b${endMarker}c\\${endMarker}d${endMarker}';
                    const TextInfo expectedResult = TextInfo(type: TextType.Normal, text: inputText);

                    final TextInfo actualResult = TextExtractor.extract(inputText, TextType.Normal, startMarker, endMarker, allowNested: true);

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Nested with escaped second finisher, unclosed', ()
                {
                    const String inputText = '${startMarker}a${startMarker}b${endMarker}c\\${endMarker}';

                    expect(() => TextExtractor.extract(inputText, TextType.Normal, startMarker, endMarker, allowNested: true), throwsA(isA<Exception>()));
                }
            );

        }
    );
}
