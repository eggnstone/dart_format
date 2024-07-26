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
                    'abc"def"': <TextInfo>
                    [
                        const TextInfo(type: TextType.Normal, text: 'abc'),
                        const TextInfo(type: TextType.String, text: '"def"'),
                    ],
                    '"def"abc': <TextInfo>
                    [
                        const TextInfo(type: TextType.String, text: '"def"'),
                        const TextInfo(type: TextType.Normal, text: 'abc'),
                    ],
                    "abc'def'": <TextInfo>
                    [
                        const TextInfo(type: TextType.Normal, text: 'abc'),
                        const TextInfo(type: TextType.String, text: "'def'"),
                    ],
                    "'def'abc": <TextInfo>
                    [
                        const TextInfo(type: TextType.String, text: "'def'"),
                        const TextInfo(type: TextType.Normal, text: 'abc'),
                    ],
                    'abc/*Comment*/': <TextInfo>
                    [
                        const TextInfo(type: TextType.Normal, text: 'abc'),
                        const TextInfo(type: TextType.Comment, text: '/*Comment*/'),
                    ],
                    '/*Comment*/abc': <TextInfo>
                    [
                        const TextInfo(type: TextType.Comment, text: '/*Comment*/'),
                        const TextInfo(type: TextType.Normal, text: 'abc'),
                    ],
                    'abc//Comment': <TextInfo>
                    [
                        const TextInfo(type: TextType.Normal, text: 'abc'),
                        const TextInfo(type: TextType.Comment, text: '//Comment'),
                    ],
                    '//Comment\nabc': <TextInfo>
                    [
                        const TextInfo(type: TextType.Comment, text: '//Comment'),
                        const TextInfo(type: TextType.Normal, text: '\nabc'),
                    ],
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
