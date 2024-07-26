import 'package:dart_format/src/Tools/StringTools.dart';
import 'package:test/test.dart';

import '../../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('RemoveLeadingWhitespace, comments in strings', ()
        {
            test('"/*"', ()
                {
                    const String inputText = 'String s="/*";';
                    const String expectedText = inputText;

                    final String actualText = StringTools.removeLeadingWhitespace(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test("'/*'", ()
                {
                    const String inputText = "String s='/*';";
                    const String expectedText = inputText;

                    final String actualText = StringTools.removeLeadingWhitespace(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test("'//'", ()
                {
                    const String inputText = "String s='//';";
                    const String expectedText = inputText;

                    final String actualText = StringTools.removeLeadingWhitespace(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
