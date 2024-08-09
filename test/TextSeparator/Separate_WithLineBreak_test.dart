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
                    const String baseText = '';
                    const String inputText = '$baseText\n';
                    const List<TextInfo> expectedResult = <TextInfo>[TextInfo(type: TextType.Normal, text: inputText)];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Normal text', ()
                {
                    const String baseText = 'abc';
                    const String inputText = '$baseText\n';
                    const List<TextInfo> expectedResult = <TextInfo>[TextInfo(type: TextType.Normal, text: inputText)];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Single-quote string', ()
                {
                    const String baseText = "'abc'";
                    const String inputText = '$baseText\n';
                    const List<TextInfo> expectedResult = <TextInfo>[
                        TextInfo(type: TextType.String, text: baseText),
                        TextInfo(type: TextType.Normal, text: '\n')
                    ];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Raw single-quote string', ()
                {
                    const String baseText = "r'abc'";
                    const String inputText = '$baseText\n';
                    const List<TextInfo> expectedResult = <TextInfo>[
                        TextInfo(type: TextType.String, text: baseText),
                        TextInfo(type: TextType.Normal, text: '\n')
                    ];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Triple single-quote string', ()
                {
                    const String baseText = "'''abc'''";
                    const String inputText = '$baseText\n';
                    const List<TextInfo> expectedResult = <TextInfo>[
                        TextInfo(type: TextType.String, text: baseText),
                        TextInfo(type: TextType.Normal, text: '\n')
                    ];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Raw triple single-quote string', ()
                {
                    const String baseText = "r'''abc'''";
                    const String inputText = '$baseText\n';
                    const List<TextInfo> expectedResult = <TextInfo>[
                        TextInfo(type: TextType.String, text: baseText),
                        TextInfo(type: TextType.Normal, text: '\n')
                    ];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Double-quote string', ()
                {
                    const String baseText = '"abc"';
                    const String inputText = '$baseText\n';
                    const List<TextInfo> expectedResult = <TextInfo>[
                        TextInfo(type: TextType.String, text: baseText),
                        TextInfo(type: TextType.Normal, text: '\n')
                    ];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Raw double-quote string', ()
                {
                    const String baseText = 'r"abc"';
                    const String inputText = '$baseText\n';
                    const List<TextInfo> expectedResult = <TextInfo>[
                        TextInfo(type: TextType.String, text: baseText),
                        TextInfo(type: TextType.Normal, text: '\n')
                    ];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Triple double-quote string', ()
                {
                    const String baseText = '"""abc"""';
                    const String inputText = '$baseText\n';
                    const List<TextInfo> expectedResult = <TextInfo>[
                        TextInfo(type: TextType.String, text: baseText),
                        TextInfo(type: TextType.Normal, text: '\n')
                    ];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Raw triple double-quote string', ()
                {
                    const String baseText = 'r"""abc"""';
                    const String inputText = '$baseText\n';
                    const List<TextInfo> expectedResult = <TextInfo>[
                        TextInfo(type: TextType.String, text: baseText),
                        TextInfo(type: TextType.Normal, text: '\n')
                    ];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('EndOfLine comment', ()
                {
                    const String baseText = '//Comment';
                    const String inputText = '$baseText\n';
                    const List<TextInfo> expectedResult = <TextInfo>[
                        TextInfo(type: TextType.Comment, text: baseText),
                        TextInfo(type: TextType.Normal, text: '\n')
                    ];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Block comment', ()
                {
                    const String baseText = '/*Comment*/';
                    const String inputText = '$baseText\n';
                    const List<TextInfo> expectedResult = <TextInfo>[
                        TextInfo(type: TextType.Comment, text: baseText),
                        TextInfo(type: TextType.Normal, text: '\n')
                    ];

                    final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                    expect(actualResult, equals(expectedResult));
                }
            );

            test('Triple single-quote string', ()
            {
                const String baseText = "'''TEXT'''";
                const String inputText = '$baseText\n';
                const List<TextInfo> expectedResult = <TextInfo>[
                    TextInfo(type: TextType.String, text: baseText),
                    TextInfo(type: TextType.Normal, text: '\n')
                ];

                final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                expect(actualResult, equals(expectedResult));
            }
            );

            test('Triple double-quote string', ()
            {
                const String baseText = '"""TEXT"""';
                const String inputText = '$baseText\n';
                const List<TextInfo> expectedResult = <TextInfo>[
                    TextInfo(type: TextType.String, text: baseText),
                    TextInfo(type: TextType.Normal, text: '\n')
                ];

                final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                expect(actualResult, equals(expectedResult));
            }
            );

            test(r'Triple single-quote string with ${}', ()
            {
                const String baseText = r"'''${x}'''";
                const String inputText = '$baseText\n';
                const List<TextInfo> expectedResult = <TextInfo>[
                    TextInfo(type: TextType.String, text: baseText),
                    TextInfo(type: TextType.Normal, text: '\n')
                ];

                final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                expect(actualResult, equals(expectedResult));
            }
            );

            test(r'Triple single-quote string with ${}', ()
            {
                const String baseText = r"'''${x ? '''a''' : '''b'''}'''";
                const String inputText = '$baseText\n';
                const List<TextInfo> expectedResult = <TextInfo>[
                    TextInfo(type: TextType.String, text: baseText),
                    TextInfo(type: TextType.Normal, text: '\n')
                ];

                final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                expect(actualResult, equals(expectedResult));
            }
            );

            test(r'Triple single-quote string with ${} and \}', ()
            {
                const String baseText = r"'''${x ? '''\}a\}''' : '''\}b\}'''}'''";
                const String inputText = '$baseText\n';
                const List<TextInfo> expectedResult = <TextInfo>[
                    TextInfo(type: TextType.String, text: baseText),
                    TextInfo(type: TextType.Normal, text: '\n')
                ];

                final List<TextInfo> actualResult = TextSeparator.separate(inputText, '');

                expect(actualResult, equals(expectedResult));
            }
            );
        }
    );
}
