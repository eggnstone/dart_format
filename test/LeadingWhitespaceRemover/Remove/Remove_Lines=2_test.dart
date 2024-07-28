import 'package:dart_format/src/LeadingWhitespaceRemover.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('Remove, 2 lines', ()
        {
            const String baseText = 'Line 1\nLine 2';
            const String baseInput = baseText;
            const String baseExpected = baseInput;

            test('No newlines', ()
                {
                    const String inputText = baseInput;
                    const String expectedText = baseExpected;

                    final String actualText = LeadingWhitespaceRemover.remove(inputText, removeLeadingSpaces: false);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Newline at the end', ()
                {
                    const String inputText = '$baseInput\n';
                    const String expectedText = '$baseExpected\n';

                    final String actualText = LeadingWhitespaceRemover.remove(inputText, removeLeadingSpaces: false);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Newline at the start', ()
                {
                    const String inputText = '\n$baseInput';
                    const String expectedText = '\n$baseExpected';

                    final String actualText = LeadingWhitespaceRemover.remove(inputText, removeLeadingSpaces: false);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Newline at the start and the end', ()
                {
                    const String inputText = '\n$baseInput\n';
                    const String expectedText = '\n$baseExpected\n';

                    final String actualText = LeadingWhitespaceRemover.remove(inputText, removeLeadingSpaces: false);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
