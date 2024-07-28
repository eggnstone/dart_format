import 'package:dart_format/src/Data/TextInfo.dart';
import 'package:dart_format/src/TextExtractor.dart';
import 'package:dart_format/src/Types/TextType.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('TextExtractor.extract with raw escapes', ()
        {
            test('One escape', ()
                {
                    const String inputText = r"'\'";

                    expect(() => TextExtractor.extract(inputText, TextType.String, "'", "'"), throwsA(isA<Exception>()));
                }
            );

            test('One escape, raw mode', ()
                {
                    const String inputText = r"'\'";
                    const TextInfo expectedResult = TextInfo(type: TextType.String, text: inputText);

                    final TextInfo actualResult = TextExtractor.extract(inputText, TextType.String, "'", "'", isRaw: true);

                    expect(actualResult, equals(expectedResult));
                }
            );
        }
    );
}