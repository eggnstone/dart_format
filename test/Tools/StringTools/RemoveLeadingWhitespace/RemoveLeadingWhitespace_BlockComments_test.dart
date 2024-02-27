import 'package:dart_format/src/Tools/StringTools.dart';
import 'package:test/test.dart';

import '../../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('RemoveLeadingWhitespace (Block Comments)', ()
        {
            const String DUMMY_SPACE = '          ';
            const String SPACE4 = '    ';

            test('Exact whitespace as needed, content more indented than end', ()
                {
                    const String inputText = '$DUMMY_SPACE/*\n${SPACE4}a\n*/$DUMMY_SPACE';

                    final String actualText = StringTools.removeLeadingWhitespace(inputText);

                    TestTools.expect(actualText, equals(inputText));
                }
            );

            test('Exact whitespace as needed, content less indented than end', ()
                {
                    const String inputText = '$DUMMY_SPACE/*\na\n${SPACE4}*/$DUMMY_SPACE';

                    final String actualText = StringTools.removeLeadingWhitespace(inputText);

                    TestTools.expect(actualText, equals(inputText));
                }
            );

            test('More whitespace than needed, content more indented than end', ()
                {
                    const String inputText = '$DUMMY_SPACE/*\n${SPACE4}${SPACE4}a\n${SPACE4}*/$DUMMY_SPACE';
                    const String expectedText = '$DUMMY_SPACE/*\n${SPACE4}a\n*/$DUMMY_SPACE';

                    final String actualText = StringTools.removeLeadingWhitespace(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('More whitespace than needed, content less indented than end', ()
                {
                    const String inputText = '$DUMMY_SPACE/*\n${SPACE4}a\n${SPACE4}${SPACE4}*/$DUMMY_SPACE';
                    const String expectedText = '$DUMMY_SPACE/*\na\n${SPACE4}*/$DUMMY_SPACE';

                    final String actualText = StringTools.removeLeadingWhitespace(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
