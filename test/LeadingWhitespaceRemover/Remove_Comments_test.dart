import 'package:dart_format/src/LeadingWhitespaceRemover.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('Remove, comments', ()
        {
            test('Empty', ()
                {
                    const String inputText = '';
                    const String expectedText = inputText;

                    final String actualText = LeadingWhitespaceRemover.remove(inputText, removeLeadingSpaces: false);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('EndOfLine comment', ()
                {
                    const String inputText = '// Comment';
                    const String expectedText = inputText;

                    final String actualText = LeadingWhitespaceRemover.remove(inputText, removeLeadingSpaces: false);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Block comment', ()
                {
                    const String inputText = '/* Comment */';
                    const String expectedText = inputText;

                    final String actualText = LeadingWhitespaceRemover.remove(inputText, removeLeadingSpaces: false);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Multiline block comment', ()
                {
                    const String inputText =
                        '/* Comment1\n'
                        'Comment2 */';
                    const String expectedText = inputText;

                    final String actualText = LeadingWhitespaceRemover.remove(inputText, removeLeadingSpaces: false);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Double block comment', ()
                {
                    const String inputText = '/* Comment1 *//* Comment2 */';
                    const String expectedText = inputText;

                    final String actualText = LeadingWhitespaceRemover.remove(inputText, removeLeadingSpaces: false);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
