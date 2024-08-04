import 'package:dart_format/src/Constants/Constants.dart';
import 'package:dart_format/src/LeadingWhitespaceRemover.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('RemoveFrom, comments, leading comments', ()
        {
            test('EndOfLine comment', ()
                {
                    const String inputText = ' // Comment';
                    const String expectedText = ' // Comment';

                    final String actualText = LeadingWhitespaceRemover.removeFrom(inputText, removeLeadingSpaces: false);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('EndOfLine comment, remove leading spaces', ()
                {
                    const String inputText = ' // Comment';
                    const String expectedText = '// Comment';

                    final String actualText = LeadingWhitespaceRemover.removeFrom(inputText, removeLeadingSpaces: true);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Block comment', ()
                {
                    const String inputText = ' /* Comment */';
                    const String expectedText = ' /* Comment */';

                    final String actualText = LeadingWhitespaceRemover.removeFrom(inputText, removeLeadingSpaces: false);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Block comment, remove leading spaces', ()
                {
                    const String inputText = ' /* Comment */';
                    const String expectedText = '/* Comment */';

                    final String actualText = LeadingWhitespaceRemover.removeFrom(inputText, removeLeadingSpaces: true);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Multiline block comment, leading spaces in each line', ()
                {
                    const String inputText =
                        '  /* Comment1\n'
                        '  Comment2 */';
                    const String expectedText =
                        '  ${Constants.INDENT_START}00002${Constants.INDENT_END}/* Comment1\n'
                        '${Constants.INDENT_START}2${Constants.INDENT_END}Comment2 */';

                    final String actualText = LeadingWhitespaceRemover.removeFrom(inputText, removeLeadingSpaces: false);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Multiline block comment, leading spaces in each line, remove leading spaces', ()
                {
                    const String inputText =
                        '  /* Comment1\n'
                        '  Comment2 */';
                    const String expectedText =
                        '${Constants.INDENT_START}00002${Constants.INDENT_END}/* Comment1\n'
                        '${Constants.INDENT_START}2${Constants.INDENT_END}Comment2 */';

                    final String actualText = LeadingWhitespaceRemover.removeFrom(inputText, removeLeadingSpaces: true);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
