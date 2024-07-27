import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config configNone = Config.none();
    final Formatter formatterNone = Formatter(configNone);

    group('Comments', ()
        {
            test('Block comment start in single-quote string', ()
                {
                    const String inputText = "String s = '/*';";
                    const String expectedText = inputText;

                    final String actualText = formatterNone.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Block comment start in double-quote string', ()
                {
                    const String inputText = 'String s = "/*";';
                    const String expectedText = inputText;

                    final String actualText = formatterNone.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('EndOfLine comment in single-quote string', ()
                {
                    const String inputText = "String s = '//';";
                    const String expectedText = inputText;

                    final String actualText = formatterNone.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('EndOfLine comment in double-quote string', ()
                {
                    const String inputText = 'String s = "//";';
                    const String expectedText = inputText;

                    final String actualText = formatterNone.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
