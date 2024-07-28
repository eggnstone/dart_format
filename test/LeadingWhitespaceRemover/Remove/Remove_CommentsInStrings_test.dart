import 'package:dart_format/src/LeadingWhitespaceRemover.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('Remove, comments in strings', ()
        {
            test('"/*"', ()
                {
                    const String inputText = 'String s="/*";';
                    const String expectedText = inputText;

                    final String actualText = LeadingWhitespaceRemover.remove(inputText, removeLeadingSpaces: false);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test("'/*'", ()
                {
                    const String inputText = "String s='/*';";
                    const String expectedText = inputText;

                    final String actualText = LeadingWhitespaceRemover.remove(inputText, removeLeadingSpaces: false);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test("'//'", ()
                {
                    const String inputText = "String s='//';";
                    const String expectedText = inputText;

                    final String actualText = LeadingWhitespaceRemover.remove(inputText, removeLeadingSpaces: false);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
