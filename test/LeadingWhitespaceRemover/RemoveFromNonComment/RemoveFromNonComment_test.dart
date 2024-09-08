import 'package:dart_format/src/LeadingWhitespaceRemover.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('LeadingWhitespaceRemover.removeFromNonComment', ()
        {
            test('Empty', ()
                {
                    const String inputText = '';
                    const String expectedText = '';

                    final String actualText = LeadingWhitespaceRemover.removeFromNonComment(inputText, '');

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test("' '", ()
                {
                    const String inputText = ' ';
                    const String expectedText = ' ';

                    final String actualText = LeadingWhitespaceRemover.removeFromNonComment(inputText, '');

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test(r"' \n '", ()
                {
                    const String inputText = ' \n ';
                    const String expectedText = ' \n';

                    final String actualText = LeadingWhitespaceRemover.removeFromNonComment(inputText, '');

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test("' X '", ()
                {
                    const String inputText = ' X ';
                    const String expectedText = ' X ';

                    final String actualText = LeadingWhitespaceRemover.removeFromNonComment(inputText, '');

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test(r"' X \n X '", ()
                {
                    const String inputText = ' X \n X ';
                    const String expectedText = ' X \nX ';

                    final String actualText = LeadingWhitespaceRemover.removeFromNonComment(inputText, '');

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
