import 'package:dart_format/dart_format.dart';
import 'package:dart_format/src/Tools/StringTools.dart';
import 'package:eggnstone_dart/eggnstone_dart.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('Block comments in function', ()
        {
            test('Single line on separate line', ()
                {
                    const String inputText = 
                        'void f()\n'
                        '{\n'
                        '    a;\n'
                        '    /* Comment */\n'
                        '}\n';
                    const String expectedText = inputText;

                    final Config config = Config.all();
                    final Formatter formatter = Formatter(config);

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('Single line after statement', ()
                {
                    const String inputText =
                        'void f()\n'
                        '{\n'
                        '    a; /* Comment */\n'
                        '}\n';
                    const String expectedText = inputText;

                    final Config config = Config.all();
                    final Formatter formatter = Formatter(config);

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('Multiline on separate line', ()
                {
                    const String inputText =
                        'void f()\n'
                        '{\n'
                        '    a;\n'
                        '    /* Comment\n'
                        '       Comment */\n'
                        '}\n';
                    const String expectedText = inputText;

                    final Config config = Config.all();
                    final Formatter formatter = Formatter(config);

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('Multiline after statement', ()
                {
                    const String inputText =
                        'void f()\n'
                        '{\n'
                        '    a; /* Comment\n'
                        '      Comment */\n'
                        '}\n';
                    const String expectedText = inputText;

                    final Config config = Config.all();
                    final Formatter formatter = Formatter(config);

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('Multiline on separate line before statement', ()
                {
                    const String inputText =
                        'void f()\n'
                        '{\n'
                        '    a;\n'
                        '    /* Comment\n'
                        '       Comment */\n'
                        '    b;\n'
                        '}\n';
                    const String expectedText = inputText;

                    final Config config = Config.all();
                    final Formatter formatter = Formatter(config);

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('Multiline after statement before statement', ()
                {
                    const String inputText =
                        'void f()\n'
                        '{\n'
                        '    a; /* Comment\n'
                        '         Comment */\n'
                        '    b;\n'
                        '}\n';
                    const String expectedText = inputText;

                    final Config config = Config.all();
                    final Formatter formatter = Formatter(config);

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );
        }
    );
}
