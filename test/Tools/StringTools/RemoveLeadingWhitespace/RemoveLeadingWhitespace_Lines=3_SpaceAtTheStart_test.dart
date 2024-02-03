import 'package:dart_format/src/Tools/StringTools.dart';
import 'package:test/test.dart';

import '../../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('RemoveLeadingWhitespace, 3 lines, space at the start', ()
        {
            const String baseInput = ' Line 1\n Line 2\n Line 3';
            const String baseExpected = 'Line 1\nLine 2\nLine 3';

            test('No newlines', ()
                {
                    const String inputText = baseInput;
                    const String expectedText = ' $baseExpected';

                    final String actualText = StringTools.removeLeadingWhitespace(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Newline at the end', ()
                {
                    const String inputText = '$baseInput\n';
                    const String expectedText = ' $baseExpected\n';

                    final String actualText = StringTools.removeLeadingWhitespace(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Newline at the start', ()
                {
                    const String inputText = '\n$baseInput';
                    const String expectedText = '\n$baseExpected';

                    final String actualText = StringTools.removeLeadingWhitespace(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Newline at the start and the end', ()
                {
                    const String inputText = '\n$baseInput\n';
                    const String expectedText = '\n$baseExpected\n';

                    final String actualText = StringTools.removeLeadingWhitespace(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
