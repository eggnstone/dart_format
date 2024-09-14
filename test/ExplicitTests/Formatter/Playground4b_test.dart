import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config config = Config.experimental();
    final Formatter formatter = Formatter(config);

    group('Playground 4b', ()
        {
            test('Multiline after statement -1', ()
                {
                    const String inputText =
                        'void f()\n'
                        '{\n'
                        '    a;/* Comment */\n'
                        '}\n';
                    const String expectedText = inputText;

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('Multiline after statement 0', ()
                {
                    const String inputText =
                        'void f()\n'
                        '{\n'
                        '    a; /* Comment */\n'
                        '}\n';
                    const String expectedText = inputText;

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('Multiline after statement 1', ()
                {
                    const String inputText =
                        'void f()\n'
                        '{\n'
                        '    a;  /* Comment */\n'
                        '}\n';
                    const String expectedText = inputText;

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );
        }
    );
}
