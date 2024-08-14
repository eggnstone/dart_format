import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:eggnstone_dart/eggnstone_dart.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config configAll = Config.all();
    final Formatter formatterAll = Formatter(configAll);

    group('Playground 4a1', ()
        {
            test('Multiline after statement -2', ()
                {
                    const String inputText =
                        'void f()\n'
                        '{\n'
                        '        a; /* Comment1\n'
                        'Comment2 */\n'
                        '}\n';
                    const String expectedText =
                        'void f()\n'
                        '{\n'
                        '    a;     /* Comment1\n'
                        'Comment2 */\n'
                        '}\n';

                    logDebug('inputText:\n$inputText');
                    logDebug('expectedText:\n$expectedText');

                    final String actualText = formatterAll.format(inputText);

                    logDebug('inputText:\n$inputText');
                    logDebug('actualText:\n$actualText');
                    logDebug('expectedText:\n$expectedText');

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('Multiline after statement -1', ()
                {
                    const String inputText =
                        'void f()\n'
                        '{\n'
                        '    a; /* Comment1\n'
                        'Comment2 */\n'
                        '}\n';
                    const String expectedText = inputText;

                    logDebug('inputText:\n$inputText');
                    logDebug('expectedText:\n$expectedText');

                    final String actualText = formatterAll.format(inputText);

                    logDebug('inputText:\n$inputText');
                    logDebug('actualText:\n$actualText');
                    logDebug('expectedText:\n$expectedText');

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('Multiline after statement 0', ()
                {
                    const String inputText =
                        'void f()\n'
                        '{\n'
                        '    a; /* Comment1\n'
                        '    Comment2 */\n'
                        '}\n';
                    const String expectedText = inputText;

                    logDebug('inputText:\n$inputText');
                    logDebug('expectedText:\n$expectedText');

                    final String actualText = formatterAll.format(inputText);

                    logDebug('inputText:\n$inputText');
                    logDebug('actualText:\n$actualText');
                    logDebug('expectedText:\n$expectedText');

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('Multiline after statement 1', ()
                {
                    const String inputText =
                        'void f()\n'
                        '{\n'
                        '    a; /* Comment1\n'
                        '        Comment2 */\n'
                        '}\n';
                    const String expectedText = inputText;

                    logDebug('inputText:\n$inputText');
                    logDebug('expectedText:\n$expectedText');

                    final String actualText = formatterAll.format(inputText);

                    logDebug('inputText:\n$inputText');
                    logDebug('actualText:\n$actualText');
                    logDebug('expectedText:\n$expectedText');

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('Multiline after statement 2', ()
                {
                    const String inputText =
                        'void f()\n'
                        '{\n'
                        '    a; /* Comment1\n'
                        '            Comment2 */\n'
                        '}\n';
                    const String expectedText = inputText;

                    logDebug('inputText:\n$inputText');
                    logDebug('expectedText:\n$expectedText');

                    final String actualText = formatterAll.format(inputText);

                    logDebug('inputText:\n$inputText');
                    logDebug('actualText:\n$actualText');
                    logDebug('expectedText:\n$expectedText');

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );
        }
    );
}
