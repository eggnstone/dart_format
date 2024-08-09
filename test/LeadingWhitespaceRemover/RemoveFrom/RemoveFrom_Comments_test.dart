import 'package:dart_format/src/Constants/Constants.dart';
import 'package:dart_format/src/LeadingWhitespaceRemover.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('RemoveFrom, comments', ()
        {
            test('Empty', ()
                {
                    const String inputText = '';
                    const String expectedText = inputText;

                    final String actualText = LeadingWhitespaceRemover.removeFrom(inputText, removeLeadingSpaces: false);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('EndOfLine comment', ()
                {
                    const String inputText = '// Comment';
                    const String expectedText = inputText;

                    final String actualText = LeadingWhitespaceRemover.removeFrom(inputText, removeLeadingSpaces: false);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Block comment', ()
                {
                    const String inputText = '/* Comment */';
                    const String expectedText = inputText;

                    final String actualText = LeadingWhitespaceRemover.removeFrom(inputText, removeLeadingSpaces: false);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Multiline block comment', ()
                {
                    const String inputText =
                        '/* Comment1\n'
                        'Comment2 */';
                    const String expectedText =
                        '${Constants.INDENT_START}00000000${Constants.INDENT_END}/* Comment1\n'
                        '${Constants.INDENT_START}0${Constants.INDENT_END}Comment2 */';

                    final String actualText = LeadingWhitespaceRemover.removeFrom(inputText, removeLeadingSpaces: false);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Double block comment', ()
                {
                    const String inputText = '/* Comment1 *//* Comment2 */';
                    const String expectedText = inputText;

                    final String actualText = LeadingWhitespaceRemover.removeFrom(inputText, removeLeadingSpaces: false);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}