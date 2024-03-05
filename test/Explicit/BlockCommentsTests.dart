import 'package:dart_format/dart_format.dart';
import 'package:dart_format/src/Analyzer.dart';
import 'package:dart_format/src/Tools/StringTools.dart';
import 'package:eggnstone_dart/eggnstone_dart.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('BlockCommentsTests', ()
        {
            test('Comment only - no changes expected', ()
                {
                    const String inputText = 
                    '/*START\n'
                    '    TEXT\n'
                    'END*/\n';

                    Analyzer().analyze(inputText);

                    final Config config = Config.all();
                    final Formatter formatter = Formatter(config);

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(inputText));
                    logDebug('actualText:\n${StringTools.toDisplayString(actualText)}\n$actualText');
                }
            );

            test('Comment only - indented 1 level too far - removal of 1 level expected', ()
                {
                    const String inputText =
                    '    /*START\n'
                    '        TEXT\n'
                    '    END*/\n';

                    const String expectedText =
                    '/*START\n'
                    '    TEXT\n'
                    'END*/\n';

                    Analyzer().analyze(inputText);

                    final Config config = Config.all();
                    final Formatter formatter = Formatter(config);

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    logDebug('actualText:\n${StringTools.toDisplayString(actualText)}\n$actualText');
                }
            );

            test('Comment in function - indented 1 level too less - addition of 1 level expected', ()
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

                    Analyzer().analyze(inputText);

                    final Config config = Config.all();
                    final Formatter formatter = Formatter(config);

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    logDebug('actualText:\n${StringTools.toDisplayString(actualText)}\n$actualText');
                }
            );

            test('Comment in function - no changes expected', ()
                {
                    const String inputText = 'void f()\n'
                    '{\n'
                    '    /*START\n'
                    '        TEXT\n'
                    '    END*/\n'
                    '    s;\n'
                    '}\n';

                    Analyzer().analyze(inputText);

                    final Config config = Config.all();
                    final Formatter formatter = Formatter(config);

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(inputText));
                    logDebug('actualText:\n${StringTools.toDisplayString(actualText)}\n$actualText');
                }
            );

            test('Comment in function - indented 1 level too far - removal of 1 level expected', ()
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

                    Analyzer().analyze(inputText);

                    final Config config = Config.all();
                    final Formatter formatter = Formatter(config);

                    final String actualText = formatter.format(expectedText);

                    TestTools.expect(actualText, equals(inputText));
                    logDebug('actualText:\n${StringTools.toDisplayString(actualText)}\n$actualText');
                }
            );

            test('Comment in function - Prevent negative indentation', ()
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

                Analyzer().analyze(inputText);

                final Config config = Config.all();
                final Formatter formatter = Formatter(config);

                final String actualText = formatter.format(expectedText);

                TestTools.expect(actualText, equals(inputText));
                logDebug('actualText:\n${StringTools.toDisplayString(actualText)}\n$actualText');
            }
            );

            test('Comment after semicolon - no changes expected', ()
                {
                    const String inputText = 'int i=0; /*START\n'
                    '        TEXT\n'
                    '    END*/\n';

                    Analyzer().analyze(inputText);

                    final Config config = Config.all();
                    final Formatter formatter = Formatter(config);

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(inputText));
                    logDebug('actualText:\n${StringTools.toDisplayString(actualText)}\n$actualText');
                }
            );

            test('Comment after semicolon - Prevent negative indentation', ()
                {
                    const String inputText = '    int i=0; /*START\n'
                    '    TEXT\n'
                    'END*/\n';

                    const String expectedText = 'int i=0;     /*START\n'
                    '    TEXT\n'
                    'END*/\n';

                    Analyzer().analyze(inputText);

                    final Config config = Config.all();
                    final Formatter formatter = Formatter(config);

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    logDebug('actualText:\n${StringTools.toDisplayString(actualText)}\n$actualText');
                }
            );
        }
    );
}
