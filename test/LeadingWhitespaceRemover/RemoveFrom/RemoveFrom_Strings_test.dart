import 'package:dart_format/src/LeadingWhitespaceRemover.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('RemoveFrom, strings', ()
        {
            test(r"String s='\'';", ()
                {
                    const String inputText = r"String s='\'';";
                    const String expectedText = inputText;

                    final String actualText = LeadingWhitespaceRemover.removeFrom(inputText, removeLeadingSpaces: false);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test(r'String s="\"";', ()
                {
                    const String inputText = r'String s="\"";';
                    const String expectedText = inputText;

                    final String actualText = LeadingWhitespaceRemover.removeFrom(inputText, removeLeadingSpaces: false);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test(r"r'\', raw mode", ()
                {
                    const String inputText = r"r'\';";
                    const String expectedText = inputText;

                    final String actualText = LeadingWhitespaceRemover.removeFrom(inputText, removeLeadingSpaces: false);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
