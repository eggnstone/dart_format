import 'package:dart_format/src/LeadingWhitespaceRemover.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('LeadingWhitespaceRemover.removeFromComment', ()
        {
            test('Empty', ()
                {
                    const String currentLineSoFar = '';
                    const String inputText = '';
                    const String expectedText = '';

                    final String actualText = LeadingWhitespaceRemover.removeFromComment(currentLineSoFar, inputText, '');

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Leading block comment, single line block comment', ()
                {
                    const String currentLineSoFar = '    */';
                    const String inputText = '/**/';
                    const String expectedText = '/**/';

                    final String actualText = LeadingWhitespaceRemover.removeFromComment(currentLineSoFar, inputText, '');

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Leading block comment, multiline block comment', ()
                {
                    const String currentLineSoFar = '    */';
                    const String inputText = '/*\n*/';
                    const String expectedText = '/*\n*/';

                    final String actualText = LeadingWhitespaceRemover.removeFromComment(currentLineSoFar, inputText, '');

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
