import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config configAll = Config.all();
    final Formatter formatterAll = Formatter(configAll);

    group('Block comments in function, before statement', ()
        {
            test('Addition of 1 level expected', ()
                {
                    const String inputText =
                        'void f()\n'
                        '{\n'
                        '/*START\n'
                        '    TEXT\n'
                        'END*/\n'
                        '    s;\n'
                        '}\n';
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('No changes expected', ()
                {
                    const String inputText =
                        'void f()\n'
                        '{\n'
                        '    /*START\n'
                        '        TEXT\n'
                        '    END*/\n'
                        '    s;\n'
                        '}\n';
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('Removal of 1 level expected', ()
                {
                    const String inputText =
                        'void f()\n'
                        '{\n'
                        '        /*START\n'
                        '            TEXT\n'
                        '        END*/\n'
                        '    s;\n'
                        '}\n';
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('Prevent negative indentation', ()
                {
                    const String inputText =
                        'void f()\n'
                        '{\n'
                        '        /*START\n'
                        '    TEXT\n'
                        'END*/\n'
                        '    s;\n'
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
