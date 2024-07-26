import 'package:dart_format/src/Data/TextInfo.dart';
import 'package:dart_format/src/TextSeparator.dart';
import 'package:dart_format/src/Types/TextType.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('TextSeparator.Separate with line break', ()
        {
            test('Empty', ()
                {
                    const String inputText = '\n';
                    const List<TextInfo> expectedResult = <TextInfo>[TextInfo(type: TextType.Normal, text: '\n')];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Normal text', ()
                {
                    const String inputText = 'abc\n';
                    const List<TextInfo> expectedResult = <TextInfo>[TextInfo(type: TextType.Normal, text: 'abc\n')];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Single-quote string', ()
                {
                    const String inputText = "'abc'\n";
                    const List<TextInfo> expectedResult = <TextInfo>[
                        TextInfo(type: TextType.String, text: "'abc'"),
                        TextInfo(type: TextType.Normal, text: '\n')
                    ];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Double-quote string', ()
                {
                    const String inputText = '"abc"\n';
                    const List<TextInfo> expectedResult = <TextInfo>[
                        TextInfo(type: TextType.String, text: '"abc"'),
                        TextInfo(type: TextType.Normal, text: '\n')
                    ];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('EndOfLine comment', ()
                {
                    const String inputText = '//Comment\n';
                    const List<TextInfo> expectedResult = <TextInfo>[
                        TextInfo(type: TextType.Comment, text: '//Comment'),
                        TextInfo(type: TextType.Normal, text: '\n')
                    ];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );


            test('Block comment', ()
                {
                    const String inputText = '/*Comment*/\n';
                    const List<TextInfo> expectedResult = <TextInfo>[
                        TextInfo(type: TextType.Comment, text: '/*Comment*/'),
                        TextInfo(type: TextType.Normal, text: '\n')
                    ];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );
        }
    );
}
