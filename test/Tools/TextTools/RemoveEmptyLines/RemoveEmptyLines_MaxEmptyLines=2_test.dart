import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Tools/TextTools.dart';
import 'package:test/test.dart';

import '../../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config config = Config.none(maxEmptyLines: 2);
    final TextTools textTools = TextTools(config);

    group('RemoveEmptyLines MaxEmptyLines=2', ()
        {
            test('1 line, no newline at the end', ()
                {
                    const String inputText = 'Line 1';
                    const String expectedText = 'Line 1';

                    final String actualText = textTools.removeEmptyLines(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('1 line, newline at the end', ()
                {
                    const String inputText = 'Line 1\n';
                    const String expectedText = 'Line 1\n';

                    final String actualText = textTools.removeEmptyLines(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('2 lines, no empty lines', ()
                {
                    const String inputText = 'Line 1\nLine 2';
                    const String expectedText = 'Line 1\nLine 2';

                    final String actualText = textTools.removeEmptyLines(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('2 lines, 1 empty line', ()
                {
                    const String inputText = 'Line 1\n\nLine 2';
                    const String expectedText = 'Line 1\n\nLine 2';

                    final String actualText = textTools.removeEmptyLines(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('2 lines, 2 empty lines', ()
                {
                    const String inputText = 'Line 1\n\n\nLine 2';
                    const String expectedText = 'Line 1\n\n\nLine 2';

                    final String actualText = textTools.removeEmptyLines(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('2 lines, 3 empty lines', ()
                {
                    const String inputText = 'Line 1\n\n\n\nLine 2';
                    const String expectedText = 'Line 1\n\n\nLine 2';

                    final String actualText = textTools.removeEmptyLines(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
