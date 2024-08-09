import 'package:dart_format/src/Data/TextInfo.dart';
import 'package:dart_format/src/TextSeparator.dart';
import 'package:dart_format/src/Tools/StringTools.dart';
import 'package:dart_format/src/Types/TextType.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('TextSeparator.Separate parameterized', ()
        {
            final Map<String, List<TextInfo>> inputs =
                <String, List<TextInfo>>
                {
                    // End-of-line comments

                    // Text before end-of-line comment
                    'abc//Comment': <TextInfo>
                    [
                        const TextInfo(type: TextType.Normal, text: 'abc'),
                        const TextInfo(type: TextType.Comment, text: '//Comment')
                    ],
                    // End-of-line comment before text
                    '//Comment\nabc': <TextInfo>
                    [
                        const TextInfo(type: TextType.Comment, text: '//Comment'),
                        const TextInfo(type: TextType.Normal, text: '\nabc')
                    ],

                    // Block comments

                    // Text before block comment
                    'abc/*Comment*/': <TextInfo>
                    [
                        const TextInfo(type: TextType.Normal, text: 'abc'),
                        const TextInfo(type: TextType.Comment, text: '/*Comment*/')
                    ],
                    // Block comment before text
                    '/*Comment*/abc': <TextInfo>
                    [
                        const TextInfo(type: TextType.Comment, text: '/*Comment*/'),
                        const TextInfo(type: TextType.Normal, text: 'abc')
                    ],

                    // Single-quote strings

                    // Text before single-quote string
                    "abc'def'": <TextInfo>
                    [
                        const TextInfo(type: TextType.Normal, text: 'abc'),
                        const TextInfo(type: TextType.String, text: "'def'")
                    ],
                    // Text before raw single-quote string
                    "abcr'def'": <TextInfo>
                    [
                        const TextInfo(type: TextType.Normal, text: 'abc'),
                        const TextInfo(type: TextType.String, text: "r'def'")
                    ],
                    // Single-quote string before text
                    "'def'abc": <TextInfo>
                    [
                        const TextInfo(type: TextType.String, text: "'def'"),
                        const TextInfo(type: TextType.Normal, text: 'abc')
                    ],
                    // Raw single-quote string before text
                    "r'def'abc": <TextInfo>
                    [
                        const TextInfo(type: TextType.String, text: "r'def'"),
                        const TextInfo(type: TextType.Normal, text: 'abc')
                    ],

                    // Triple single-quote strings

                    // Text before triple single-quote string
                    "abc'''def'''": <TextInfo>
                    [
                        const TextInfo(type: TextType.Normal, text: 'abc'),
                        const TextInfo(type: TextType.String, text: "'''def'''")
                    ],
                    // Text before raw triple single-quote string
                    "abcr'''def'''": <TextInfo>
                    [
                        const TextInfo(type: TextType.Normal, text: 'abc'),
                        const TextInfo(type: TextType.String, text: "r'''def'''")
                    ],
                    // Triple Single-quote string before text
                    "'''def'''abc": <TextInfo>
                    [
                        const TextInfo(type: TextType.String, text: "'''def'''"),
                        const TextInfo(type: TextType.Normal, text: 'abc')
                    ],
                    // Raw triple single-quote string before text
                    "r'''def'''abc": <TextInfo>
                    [
                        const TextInfo(type: TextType.String, text: "r'''def'''"),
                        const TextInfo(type: TextType.Normal, text: 'abc')
                    ],

                    // Double-quote strings

                    // Text before double-quote string
                    'abc"def"': <TextInfo>
                    [
                        const TextInfo(type: TextType.Normal, text: 'abc'),
                        const TextInfo(type: TextType.String, text: '"def"')
                    ],
                    // Text before raw double-quote string
                    'abcr"def"': <TextInfo>
                    [
                        const TextInfo(type: TextType.Normal, text: 'abc'),
                        const TextInfo(type: TextType.String, text: 'r"def"')
                    ],
                    // Double-quote string before text
                    '"def"abc': <TextInfo>
                    [
                        const TextInfo(type: TextType.String, text: '"def"'),
                        const TextInfo(type: TextType.Normal, text: 'abc')
                    ],
                    // Raw double-quote string before text
                    'r"def"abc': <TextInfo>
                    [
                        const TextInfo(type: TextType.String, text: 'r"def"'),
                        const TextInfo(type: TextType.Normal, text: 'abc')
                    ],

                    // Triple double-quote strings

                    // Text before triple double-quote string
                    'abc"""def"""': <TextInfo>
                    [
                        const TextInfo(type: TextType.Normal, text: 'abc'),
                        const TextInfo(type: TextType.String, text: '"""def"""')
                    ],
                    // Text before raw triple double-quote string
                    'abcr"""def"""': <TextInfo>
                    [
                        const TextInfo(type: TextType.Normal, text: 'abc'),
                        const TextInfo(type: TextType.String, text: 'r"""def"""')
                    ],
                    // Triple Double-quote string before text
                    '"""def"""abc': <TextInfo>
                    [
                        const TextInfo(type: TextType.String, text: '"""def"""'),
                        const TextInfo(type: TextType.Normal, text: 'abc')
                    ],
                    // Raw triple double-quote string before text
                    'r"""def"""abc': <TextInfo>
                    [
                        const TextInfo(type: TextType.String, text: 'r"""def"""'),
                        const TextInfo(type: TextType.Normal, text: 'abc')
                    ]
                };

            inputs.forEach((String input, List<TextInfo> expected)
                {
                    test('${StringTools.toDisplayString(input)} -> $expected', ()
                        {
                            expect(TextSeparator.separate(input, ''), expected);
                        }
                    );
                }
            );
        }
    );
}
