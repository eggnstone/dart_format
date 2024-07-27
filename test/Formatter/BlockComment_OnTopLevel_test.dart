import 'package:dart_format/dart_format.dart';
import 'package:dart_format/src/Tools/StringTools.dart';
import 'package:eggnstone_dart/eggnstone_dart.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('Block comments on top level', ()
        {
            group('Comment only', ()
                {
                    test('No changes expected', ()
                        {
                            const String inputText =
                                '/*START\n'
                                '    TEXT\n'
                                'END*/\n';
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
                            const String inputText =
                                '    /*START\n'
                                '        TEXT\n'
                                '    END*/\n';
                            const String expectedText =
                                '/*START\n'
                                '    TEXT\n'
                                'END*/\n';

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
                    test('No changes expected', ()
                        {
                            const String inputText =
                                '/*START\n'
                                '    TEXT\n'
                                'END*/\n'
                                'var a;\n';
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

                            final Config config = Config.all();
                            final Formatter formatter = Formatter(config);

                            final String actualText = formatter.format(inputText);

                            TestTools.expect(actualText, equals(expectedText));
                            logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
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
                                        '        TEXT\n'
                                        '    END*/\n';

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
                            const String expectedText = 'int i=0;    /*START\n'
                                '    TEXT\n'
                                'END*/\n';

                            final Config config = Config.all();
                            final Formatter formatter = Formatter(config);

                            final String actualText = formatter.format(inputText);

                            TestTools.expect(actualText, equals(expectedText));
                            logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                        }
                    );
                }
            );

            group('Nested', ()
                {
                    test('2 layers', ()
                        {
                            const String inputText = '/*/**/*/\n';
                            const String expectedText = inputText;

                            final Config config = Config.all();
                            final Formatter formatter = Formatter(config);

                            final String actualText = formatter.format(inputText);

                            TestTools.expect(actualText, equals(expectedText));
                            logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                        }
                    );

                    test('2 layers with string-start', ()
                        {
                            const String inputText = "/*/**/'*/\n";
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
    );
}
