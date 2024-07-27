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
            test('Addition of 1 level expected', ()
                {
                    const String inputText = 'void f()\n'
                        '{\n'
                        '/*START\n'
                        '    TEXT\n'
                        'END*/\n'
                        '    s;\n'
                        '}\n';

                    const String expectedText = 'void f()\n'
                        '{\n'
                        '    /*START\n'
                        '        TEXT\n'
                        '    END*/\n'
                        '    s;\n'
                        '}\n';

                    final Config config = Config.all();
                    final Formatter formatter = Formatter(config);

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('No changes expected', ()
                {
                    const String inputText = 'void f()\n'
                        '{\n'
                        '    /*START\n'
                        '        TEXT\n'
                        '    END*/\n'
                        '    s;\n'
                        '}\n';
                    const String expectedText = inputText;

                    final Config config = Config.all();
                    final Formatter formatter = Formatter(config);

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('Removal of 1 level expected', ()
                {
                    const String inputText = 'void f()\n'
                        '{\n'
                        '        /*START\n'
                        '            TEXT\n'
                        '        END*/\n'
                        '    s;\n'
                        '}\n';

                    const String expectedText = 'void f()\n'
                        '{\n'
                        '    /*START\n'
                        '        TEXT\n'
                        '    END*/\n'
                        '    s;\n'
                        '}\n';

                    final Config config = Config.all();
                    final Formatter formatter = Formatter(config);

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('Prevent negative indentation', ()
                {
                    const String inputText = 'void f()\n'
                        '{\n'
                        '        /*START\n'
                        '    TEXT\n'
                        'END*/\n'
                        '    s;\n'
                        '}\n';

                    const String expectedText = 'void f()\n'
                        '{\n'
                        '            /*START\n'
                        '        TEXT\n'
                        '    END*/\n'
                        '    s;\n'
                        '}\n';

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
