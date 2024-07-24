import 'package:dart_format/dart_format.dart';
import 'package:dart_format/src/Analyzer.dart';
import 'package:dart_format/src/Tools/StringTools.dart';
import 'package:eggnstone_dart/eggnstone_dart.dart';
import 'package:test/test.dart';

import '../../tests/TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('Block comments', ()
        {
    group('In function', ()
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

            Analyzer().analyze(inputText);

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

            Analyzer().analyze(inputText);

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

            Analyzer().analyze(inputText);

            final Config config = Config.all();
            final Formatter formatter = Formatter(config);

            final String actualText = formatter.format(expectedText);

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

            Analyzer().analyze(inputText);

            final Config config = Config.all();
            final Formatter formatter = Formatter(config);

            final String actualText = formatter.format(expectedText);

            TestTools.expect(actualText, equals(expectedText));
            logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
        }
        );
    }
    );

    group('Comment only', () {
        test('No changes expected', () {
            const String inputText =
                '/*START\n'
                '    TEXT\n'
                'END*/\n';
            const String expectedText = inputText;

            Analyzer().analyze(inputText);

            final Config config = Config.all();
            final Formatter formatter = Formatter(config);

            final String actualText = formatter.format(inputText);

            TestTools.expect(actualText, equals(expectedText));
            logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
        }
        );

        test('Removal of 1 level expected', ()
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
            logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
        }
        );
    }
    );

    group('Before statement', ()
    {
    group('Multiline block comment', ()
    {
            test('No changes expected', ()
                {
                    const String inputText =
                        '/*START\n'
                        '    TEXT\n'
                        'END*/\n'
                        'var a;\n';
                    const String expectedText = inputText;

                    Analyzer().analyze(inputText);

                    final Config config = Config.all();
                    final Formatter formatter = Formatter(config);

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('Removal of 1 level expected', ()
                {
                    const String inputText =
                        '    /*START\n'
                        '        TEXT\n'
                        '    END*/\n'
                        '    var a;\n';
                    const String expectedText =
                        '/*START\n'
                        '    TEXT\n'
                        'END*/\n'
                        'var a;\n';

                    Analyzer().analyze(inputText);

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
    );



    group('After statement', ()
    {
            test('No changes expected', ()
                {
                    const String inputText = 'int i=0; /*START\n'
                    '        TEXT\n'
                    '    END*/\n';
                    const String expectedText = inputText;

                    Analyzer().analyze(inputText);

                    final Config config = Config.all();
                    final Formatter formatter = Formatter(config);

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            group('Removal of 1 level expected', ()
            {
            test('Comment starts on separate line', ()
            {
                const String inputText = '    int i=0;\n'
                    '    /*START\n'
                    '        TEXT\n'
                    '    END*/\n';

                const String expectedText = 'int i=0;\n'
                    '/*START\n'
                    '    TEXT\n'
                    'END*/\n';

                Analyzer().analyze(inputText);

                final Config config = Config.all();
                final Formatter formatter = Formatter(config);

                final String actualText = formatter.format(inputText);

                TestTools.expect(actualText, equals(expectedText));
                logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
            }
            );

            test('Comment starts on separate line 2', ()
            {
                const String inputText = '    int i=0;\n'
                    '    /*START\n'
                    '        TEXT\n'
                    '    END*/\n'
                    '    var a;\n';

                const String expectedText = 'int i=0;\n'
                    '/*START\n'
                    '    TEXT\n'
                    'END*/\n'
                    'var a;\n';

                Analyzer().analyze(inputText);

                final Config config = Config.all();
                final Formatter formatter = Formatter(config);

                final String actualText = formatter.format(inputText);

                TestTools.expect(actualText, equals(expectedText));
                logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
            }
            );

            test('Comment starts on the same line', ()
            {
                const String inputText = '    int i=0; /*START\n'
                    '        TEXT\n'
                    '    END*/\n';

                const String expectedText = 'int i=0; /*START\n'
                    '    TEXT\n'
                    'END*/\n';

                Analyzer().analyze(inputText);

                final Config config = Config.all();
                final Formatter formatter = Formatter(config);

                final String actualText = formatter.format(inputText);

                TestTools.expect(actualText, equals(expectedText));
                logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
            }
            );
            }
            );

            test('Prevent negative indentation', ()
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
                    logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );
        }
    );
        }
    );
}
