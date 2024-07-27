import 'package:dart_format/src/Data/TextInfo.dart';
import 'package:dart_format/src/TextSeparator.dart';
import 'package:dart_format/src/Types/TextType.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('TextSeparator.Separate', ()
        {
            test('Empty', ()
                {
                    const String inputText = '';
                    const List<TextInfo> expectedResult = <TextInfo>[];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Normal text', ()
                {
                    const String inputText = 'abc';
                    const List<TextInfo> expectedResult = <TextInfo>[TextInfo(type: TextType.Normal, text: 'abc')];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Single-quote string', ()
                {
                    const String inputText = "'abc'";
                    const List<TextInfo> expectedResult = <TextInfo>[TextInfo(type: TextType.String, text: "'abc'")];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Double-quote string', ()
                {
                    const String inputText = '"abc"';
                    const List<TextInfo> expectedResult = <TextInfo>[TextInfo(type: TextType.String, text: '"abc"')];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('EndOfLine comment', ()
                {
                    const String inputText = '//Comment';
                    const List<TextInfo> expectedResult = <TextInfo>[TextInfo(type: TextType.Comment, text: '//Comment')];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Block comment', ()
                {
                    const String inputText = '/*Comment*/';
                    const List<TextInfo> expectedResult = <TextInfo>[TextInfo(type: TextType.Comment, text: '/*Comment*/')];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );
        }
    );
}
