import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config configAll = Config.all();
    final Formatter formatterAll = Formatter(configAll);

    group('Block comments on top level', ()
        {
            group('Comment only', ()
                {
                    test('No changes expected, 3 lines', ()
                        {
                            const String inputText =
                                '/*START\n'
                                '    TEXT\n'
                                'END*/\n';
                            const String expectedText = inputText;

                            final String actualText = formatterAll.format(inputText);

                            TestTools.expect(actualText, equals(expectedText));
                            //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                        }
                    );

                    test('No changes expected, 3 lines with 1 empty line', ()
                        {
                            const String inputText =
                                '/*START\n'
                                '\n'
                                'END*/\n';
                            const String expectedText = inputText;

                            final String actualText = formatterAll.format(inputText);

                            TestTools.expect(actualText, equals(expectedText));
                            //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
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

                            final String actualText = formatterAll.format(inputText);

                            TestTools.expect(actualText, equals(expectedText));
                            //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
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

                            final String actualText = formatterAll.format(inputText);

                            TestTools.expect(actualText, equals(expectedText));
                            //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
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

                            final String actualText = formatterAll.format(inputText);

                            TestTools.expect(actualText, equals(expectedText));
                            //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
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

                            final String actualText = formatterAll.format(inputText);

                            TestTools.expect(actualText, equals(expectedText));
                            //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
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

                                    final String actualText = formatterAll.format(inputText);

                                    TestTools.expect(actualText, equals(expectedText));
                                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
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

                                    final String actualText = formatterAll.format(inputText);

                                    TestTools.expect(actualText, equals(expectedText));
                                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                                }
                            );

                            test('Comment starts on the same line', ()
                                {
                                    const String inputText = '    int i=0; /*START\n'
                                        '        TEXT\n'
                                        '    END*/';
                                    const String expectedText = 'int i=0; /*START\n'
                                        '    TEXT\n'
                                        'END*/\n';

                                    final String actualText = formatterAll.format(inputText);

                                    TestTools.expect(actualText, equals(expectedText));
                                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                                }
                            );

                            test('Comment starts on the same line before line break', ()
                                {
                                    const String inputText = '    int i=0; /*START\n'
                                        '        TEXT\n'
                                        '    END*/\n';
                                    const String expectedText = 'int i=0; /*START\n'
                                        '    TEXT\n'
                                        'END*/\n';

                                    final String actualText = formatterAll.format(inputText);

                                    TestTools.expect(actualText, equals(expectedText));
                                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                                }
                            );

                            test('Comment starts on the same line before statement', ()
                                {
                                    const String inputText = '    int i=0; /*START\n'
                                        '        TEXT\n'
                                        '    END*/\n'
                                        '    var a;\n';
                                    const String expectedText = 'int i=0; /*START\n'
                                        '    TEXT\n'
                                        'END*/\n'
                                        'var a;\n';

                                    final String actualText = formatterAll.format(inputText);

                                    TestTools.expect(actualText, equals(expectedText));
                                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                                }
                            );
                        }
                    );

                    test('Prevent negative indentation', ()
                        {
                            const String inputText = '    int i=0; /*START\n'
                                '    TEXT\n'
                                'END*/\n';
                            const String expectedText = 'int i=0; /*START\n'
                                '    TEXT\n'
                                'END*/\n';

                            final String actualText = formatterAll.format(inputText);

                            TestTools.expect(actualText, equals(expectedText));
                            //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                        }
                    );

                    test('Prevent negative indentation before statement', ()
                        {
                            const String inputText = '    int i=0; /*START\n'
                                '    TEXT\n'
                                'END*/\n'
                                'var a;\n';
                            const String expectedText = 'int i=0; /*START\n'
                                '    TEXT\n'
                                'END*/\n'
                                'var a;\n';

                            final String actualText = formatterAll.format(inputText);

                            TestTools.expect(actualText, equals(expectedText));
                            //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
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

                            final String actualText = formatterAll.format(inputText);

                            TestTools.expect(actualText, equals(expectedText));
                            //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                        }
                    );

                    test('2 layers with string-start', ()
                        {
                            const String inputText = "/*/**/'*/\n";
                            const String expectedText = inputText;

                            final String actualText = formatterAll.format(inputText);

                            TestTools.expect(actualText, equals(expectedText));
                            //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                        }
                    );

                }
            );

            group('TODO: proper name', ()
                {

                    test('Not indented, between statements', ()
                        {
                            const String inputText =
                                'var a;/*\n'
                                '*/var b;\n';
                            const String expectedText = inputText;

                            final String actualText = formatterAll.format(inputText);

                            TestTools.expect(actualText, equals(expectedText));
                        }
                    );

                    test('Not indented, between statements, back-to-back', ()
                        {
                            const String inputText =
                                'var a;/*\n'
                                '*//*\n'
                                '*/var b;\n';
                            const String expectedText = inputText;

                            final String actualText = formatterAll.format(inputText);

                            TestTools.expect(actualText, equals(expectedText));
                        }
                    );
                }
            );

            group('Back-to-back', ()
                {
                    test('Start indented', ()
                        {
                            const String inputText =
                                '    /*\n'
                                '*//*\n'
                                '*/\n';
                            const String expectedText =
                                '/*\n'
                                '*//*\n'
                                '*/\n';

                            final String actualText = formatterAll.format(inputText);

                            TestTools.expect(actualText, equals(expectedText));
                        }
                    );

                    test('Middle indented', ()
                        {
                            const String inputText =
                                '/*\n'
                                '    *//*\n'
                                '*/\n';
                            const String expectedText = inputText;

                            final String actualText = formatterAll.format(inputText);

                            TestTools.expect(actualText, equals(expectedText));
                        }
                    );

                    test('End indented', ()
                        {
                            const String inputText =
                                '/*\n'
                                '*//*\n'
                                '    */\n';
                            const String expectedText = inputText;

                            final String actualText = formatterAll.format(inputText);

                            TestTools.expect(actualText, equals(expectedText));
                        }
                    );

                    test('Start and middle indented', ()
                        {
                            const String inputText =
                                '    /*\n'
                                '    *//*\n'
                                '*/\n';
                            const String expectedText =
                                '/*\n'
                                '*//*\n'
                                '*/\n';

                            final String actualText = formatterAll.format(inputText);

                            TestTools.expect(actualText, equals(expectedText));
                        }
                    );

                    test('Start and end indented', ()
                        {
                            const String inputText =
                                '    /*\n'
                                '*//*\n'
                                '    */\n';
                            const String expectedText =
                                '/*\n'
                                '*//*\n'
                                '    */\n';

                            final String actualText = formatterAll.format(inputText);

                            TestTools.expect(actualText, equals(expectedText));
                        }
                    );

                    test('Middle and end indented', ()
                        {
                            const String inputText =
                                '/*\n'
                                '    *//*\n'
                                '    */\n';
                            const String expectedText =
                                '/*\n'
                                '    *//*\n'
                                '*/\n';

                            final String actualText = formatterAll.format(inputText);

                            TestTools.expect(actualText, equals(expectedText));
                        }
                    );
                }
            );
        }
    );
}
