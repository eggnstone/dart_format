import 'package:dart_format/src/Data/TextInfo.dart';
import 'package:dart_format/src/TextExtractor.dart';
import 'package:dart_format/src/Types/TextType.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group(r'TextExtractor.extract with $', ()
        {
            test(r"Normal with ' and $", ()
                {
                    const String inputText = r"'a$b'";
                    const TextInfo expectedResult = TextInfo(type: TextType.String, text: inputText);

                    final TextInfo actualResult = TextExtractor.extract(inputText, TextType.String, "'", "'");

                    expect(actualResult, equals(expectedResult));
                }
            );

            test(r'Normal with " and $', ()
                {
                    const String inputText = r'"a$b"';
                    const TextInfo expectedResult = TextInfo(type: TextType.String, text: inputText);

                    final TextInfo actualResult = TextExtractor.extract(inputText, TextType.String, '"', '"');

                    expect(actualResult, equals(expectedResult));
                }
            );
        }
    );
}
