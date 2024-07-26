import 'package:dart_format/src/LeadingWhitespaceRemover.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('Remove, strings', ()
        {
            test(r"'\''", ()
                {
                    const String inputText = r"String s='\'';";
                    const String expectedText = inputText;

                    final String actualText = LeadingWhitespaceRemover.remove(inputText, removeLeadingSpaces: false);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test(r'"\""', ()
                {
                    const String inputText = r'String s="\"";';
                    const String expectedText = inputText;

                    final String actualText = LeadingWhitespaceRemover.remove(inputText, removeLeadingSpaces: false);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
