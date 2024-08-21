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
