import 'package:dart_format/dart_format.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config configNone = Config.none();
    final Formatter formatterNone = Formatter(configNone);

    group('Comments', ()
        {
            test('Block comment with block comment inside', ()
                {
                    const String inputText = '/* Comment /* */ */';
                    const String expectedText = inputText;

                    final String actualText = formatterNone.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Block comment with EndOfLine comment inside', ()
                {
                    const String inputText = '/* Comment // */';
                    const String expectedText = inputText;

                    final String actualText = formatterNone.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('EndOfLine comment with Block comment start inside', ()
                {
                    const String inputText = '// /* Comment';
                    const String expectedText = inputText;

                    final String actualText = formatterNone.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
