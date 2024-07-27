import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config configAll = Config.all();
    final Formatter formatterAll = Formatter(configAll);

    group('Block comments in function, after statement', ()
        {
            test('Single line, on separate line', ()
                {
                    const String inputText = 
                        'void f()\n'
                        '{\n'
                        '    a;\n'
                        '    /* Comment */\n'
                        '}\n';
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('Single line, on same line', ()
                {
                    const String inputText =
                        'void f()\n'
                        '{\n'
                        '    a; /* Comment */\n'
                        '}\n';
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('Multiline, on separate line', ()
                {
                    const String inputText =
                        'void f()\n'
                        '{\n'
                        '    a;\n'
                        '    /* Comment\n'
                        '        Comment */\n'
                        '}\n';
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('Multiline, on same line', ()
                {
                    const String inputText =
                        'void f()\n'
                        '{\n'
                        '    a; /* Comment\n'
                        '        Comment */\n'
                        '}\n';
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('Multiline, on separate line, before statement', ()
                {
                    const String inputText =
                        'void f()\n'
                        '{\n'
                        '    a;\n'
                        '    /* Comment\n'
                        '    Comment */\n'
                        '    b;\n'
                        '}\n';
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('Multiline, on same line, before statement', ()
                {
                    const String inputText =
                        'void f()\n'
                        '{\n'
                        '    a; /* Comment\n'
                        '        Comment */\n'
                        '    b;\n'
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
