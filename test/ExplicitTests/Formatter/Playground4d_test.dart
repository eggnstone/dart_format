import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config configAll = Config.all();
    final Formatter formatterAll = Formatter(configAll);

    group('Playground 4d', ()
        {
            test('On top level', ()
                {
                    const String inputText =
                        '/*\n'
                        '*//*\n'
                        '*/\n';
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('On top level, after statement, nothing indented', ()
                {
                    const String inputText =
                        'var v;\n'
                        '/*\n'
                        '*//*\n'
                        '*/\n';
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('On top level, after statement, end indented', ()
                {
                    const String inputText =
                        'var v;\n'
                        '/*\n'
                        '*//*\n'
                        '    */\n';
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('On top level, after statement, end indented, -cd', ()
                {
                    const String inputText =
                        'var v;\n'
                        '/*\n'
                        '*//*c\n'
                        '    d*/\n';
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('On top level, after statement, end indented, ab-cd', ()
                {
                    const String inputText =
                        'var v;\n'
                        '/*a\n'
                        'b*//*c\n'
                        '    d*/\n';
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('On top level, after statement, end x2 indented', ()
                {
                    const String inputText =
                        'var v;\n'
                        '/*\n'
                        '*//*\n'
                        '        */\n';
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('On top level, after statement, end x2 indented, -cd', ()
                {
                    const String inputText =
                        'var v;\n'
                        '/*\n'
                        '*//*c\n'
                        '        d*/\n';
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('On top level, after statement, end x2 indented, ab-cd', ()
                {
                    const String inputText =
                        'var v;\n'
                        '/*a\n'
                        'b*//*c\n'
                        '        d*/\n';
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('On top level, after statement, all + end indented', ()
                {
                    const String inputText =
                        'var v;\n'
                        '    /*\n'
                        '    *//*\n'
                        '        */\n';
                    const String expectedText = inputText;
                    /*const String expectedText =
                        'var v;\n'
                        '    /*\n'
                        '    *//*\n'
                        '    */\n';*/

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('On top level, after statement, middle + end x2 indented', ()
                {
                    const String inputText =
                        'var v;\n'
                        '/*\n'
                        '    *//*\n'
                        '        */\n';
                    const String expectedText =
                        'var v;\n'
                        '/*\n'
                        '    *//*\n'
                        '        */\n';

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('In function, end indented', ()
                {
                    const String inputText =
                        'void f()\n'
                        '{\n'
                        '    /*\n'
                        '    *//*\n'
                        '        */\n'
                        '}\n';
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );
        }
    );
}
