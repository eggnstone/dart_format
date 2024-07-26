import 'package:dart_format/dart_format.dart';
import 'package:dart_format/src/Tools/TextTools.dart';
import 'package:test/test.dart';

import '../../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    // ignore: avoid_redundant_argument_values
    final Config config = Config.none(addNewLineAtEndOfText: false);
    final TextTools textTools = TextTools(config);

    group('AddNewLineAtEndOfText=false tests', ()
        {
            test('Empty text', ()
                {
                    const String inputText = '';
                    const String expectedText = '';

                    final String actualText = textTools.addNewLineAtEndOfText(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Single space', ()
                {
                    const String inputText = ' ';
                    const String expectedText = ' ';

                    final String actualText = textTools.addNewLineAtEndOfText(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Single letter', ()
                {
                    const String inputText = 'a';
                    const String expectedText = 'a';

                    final String actualText = textTools.addNewLineAtEndOfText(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Single newline', ()
                {
                    const String inputText = '\n';
                    const String expectedText = '\n';

                    final String actualText = textTools.addNewLineAtEndOfText(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
