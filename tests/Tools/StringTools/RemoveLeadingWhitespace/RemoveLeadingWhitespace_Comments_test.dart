import 'package:dart_format/src/Tools/StringTools.dart';
import 'package:test/test.dart';

import '../../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('RemoveLeadingWhitespace, comments', ()
        {
            test('Empty', ()
                {
                    const String inputText = '';
                    const String expectedText = inputText;

                    final String actualText = StringTools.removeLeadingWhitespace(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('No leading whitespace', ()
                {
                    const String inputText = '/* Comment */';
                    const String expectedText = inputText;

                    final String actualText = StringTools.removeLeadingWhitespace(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('One leading whitespace', ()
                {
                    const String inputText = ' /* Comment */';
                    const String expectedText = '/* Comment */';

                    final String actualText = StringTools.removeLeadingWhitespace(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('One leading whitespace', ()
                {
                    const String inputText =
                        ' /* Comment1\n'
                        ' Comment2 */';
                    const String expectedText =
                        '/* Comment1\n'
                        'Comment2 */';

                    final String actualText = StringTools.removeLeadingWhitespace(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
