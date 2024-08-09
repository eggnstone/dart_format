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

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, inputText);

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Normal text', ()
                {
                    const String inputText = 'abc';
                    const List<TextInfo> expectedResult = <TextInfo>[TextInfo(type: TextType.Normal, text: inputText)];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Single-quote string', ()
                {
                    const String inputText = "'abc'";
                    const List<TextInfo> expectedResult = <TextInfo>[TextInfo(type: TextType.String, text: inputText)];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test(r'Single-quote string with ${}', ()
                {
                    const String inputText = r"'${x}'";
                    const List<TextInfo> expectedResult = <TextInfo>[TextInfo(type: TextType.String, text: inputText)];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test(r'Single-quote string with ${?:}', ()
                {
                    const String inputText = r"'${x ? 'a' : 'b'}'";
                    const List<TextInfo> expectedResult = <TextInfo>[TextInfo(type: TextType.String, text: inputText)];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test(r'Single-quote string with ${?:} and \}', ()
                {
                    const String inputText = r"'${x ? '\}a\}' : '\}b\}'}'";
                    const List<TextInfo> expectedResult = <TextInfo>[TextInfo(type: TextType.String, text: inputText)];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Raw single-quote string', ()
                {
                    const String inputText = "r'abc'";
                    const List<TextInfo> expectedResult = <TextInfo>[TextInfo(type: TextType.String, text: "r'abc'")];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Triple single-quote string', ()
                {
                    const String inputText = "'''abc'''";
                    const List<TextInfo> expectedResult = <TextInfo>[TextInfo(type: TextType.String, text: "'''abc'''")];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Raw triple single-quote string', ()
                {
                    const String inputText = "r'''abc'''";
                    const List<TextInfo> expectedResult = <TextInfo>[TextInfo(type: TextType.String, text: "r'''abc'''")];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Double-quote string', ()
                {
                    const String inputText = '"abc"';
                    const List<TextInfo> expectedResult = <TextInfo>[TextInfo(type: TextType.String, text: inputText)];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Raw double-quote string', ()
                {
                    const String inputText = 'r"abc"';
                    const List<TextInfo> expectedResult = <TextInfo>[TextInfo(type: TextType.String, text: 'r"abc"')];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Triple double-quote string', ()
                {
                    const String inputText = '"""abc"""';
                    const List<TextInfo> expectedResult = <TextInfo>[TextInfo(type: TextType.String, text: '"""abc"""')];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Raw triple double-quote string', ()
                {
                    const String inputText = 'r"""abc"""';
                    const List<TextInfo> expectedResult = <TextInfo>[TextInfo(type: TextType.String, text: 'r"""abc"""')];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('EndOfLine comment', ()
                {
                    const String inputText = '//Comment';
                    const List<TextInfo> expectedResult = <TextInfo>[TextInfo(type: TextType.Comment, text: inputText)];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Block comment', ()
                {
                    const String inputText = '/*Comment*/';
                    const List<TextInfo> expectedResult = <TextInfo>[TextInfo(type: TextType.Comment, text: inputText)];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Triple single-quote string', ()
                {
                    const String inputText = "'''TEXT'''";
                    const List<TextInfo> expectedResult = <TextInfo>[TextInfo(type: TextType.String, text: inputText)];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Triple double-quote string', ()
                {
                    const String inputText = '"""TEXT"""';
                    const List<TextInfo> expectedResult = <TextInfo>[TextInfo(type: TextType.String, text: inputText)];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test(r'Triple single-quote string with ${}', ()
                {
                    const String inputText = r"'''${x}'''";
                    const List<TextInfo> expectedResult = <TextInfo>[TextInfo(type: TextType.String, text: inputText)];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test(r'Triple single-quote string with ${?:}', ()
                {
                    const String inputText = r"'''${x ? '''a''' : '''b'''}'''";
                    const List<TextInfo> expectedResult = <TextInfo>[TextInfo(type: TextType.String, text: inputText)];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test(r'Triple single-quote string with ${?:} and \}', ()
                {
                    const String inputText = r"'''${x ? '''\}a\}''' : '''\}b\}'''}'''";
                    const List<TextInfo> expectedResult = <TextInfo>[TextInfo(type: TextType.String, text: inputText)];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );
        }
    );
}
