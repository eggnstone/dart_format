import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:dart_format/src/Tools/LogTools.dart';
import 'package:dart_format/src/Tools/StringTools.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config configAll = Config.all();
    final Formatter formatterAll = Formatter(configAll);

    group('TODO: proper name', ()
        {
            test('Not indented, between statements', ()
                {
                    const String inputText =
                        'void f()\n'
                        '{\n'
                        '    var a;/*\n'
                        '    */var b;\n'
                        '}\n';
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Not indented, between statements, back-to-back', ()
                {
                    const String inputText =
                        'void f()\n'
                        '{\n'
                        '    var a;/*\n'
                        '    *//*\n'
                        '    */var b;\n'
                        '}\n';
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );

    group('Block comments in function, alone', ()
        {
            test('1 line', ()
                {
                    const String inputText = 
                        'void f()\n'
                        '{\n'
                        '    /* Comment */\n'
                        '}\n';
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('2 lines', ()
                {
                    const String inputText =
                        'void f()\n'
                        '{\n'
                        '    /* Comment\n'
                        '    Comment */\n'
                        '}\n';
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('3 lines, with empty line', ()
                {
                    const String inputText =
                        'void f()\n'
                        '{\n'
                        '    /* Comment\n'
                        '\n'
                        '    Comment */\n'
                        '}\n';
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            group('Back-to-back', ()
                {
                    test('Not indented at all', ()
                        {
                            const String inputText =
                                'void f()\n'
                                '{\n'
                                '/*\n'
                                '*//*\n'
                                '*/\n'
                                '}\n';
                            const String expectedText =
                                'void f()\n'
                                '{\n'
                                '    /*\n'
                                '    *//*\n'
                                '    */\n'
                                '}\n';

                            final String actualText = formatterAll.format(inputText);

                            TestTools.expect(actualText, equals(expectedText));
                        }
                    );

                    test('Not indented', ()
                        {
                            const String inputText =
                                'void f()\n'
                                '{\n'
                                '    /*\n'
                                '    *//*\n'
                                '    */\n'
                                '}\n';
                            const String expectedText = inputText;

                            final String actualText = formatterAll.format(inputText);

                            logDebug('inputText:\n$inputText');
                            logDebug('actualText:\n$actualText');
                            logDebug('expectedText:\n$expectedText');

                            TestTools.expect(actualText, equals(expectedText));
                        }
                    );

                    test('Start indented', ()
                        {
                            const String inputText =
                                'void f()\n'
                                '{\n'
                                '        /*\n'
                                '    *//*\n'
                                '    */\n'
                                '}\n';
                            const String expectedText =
                                'void f()\n'
                                '{\n'
                                '    /*\n'
                                '    *//*\n'
                                '    */\n'
                                '}\n';

                            final String actualText = formatterAll.format(inputText);

                            TestTools.expect(actualText, equals(expectedText));
                        }
                    );

                    test('Middle indented', ()
                        {
                            const String inputText =
                                'void f()\n'
                                '{\n'
                                '    /*\n'
                                '        *//*\n'
                                '    */\n'
                                '}\n';
                            const String expectedText = inputText;

                            final String actualText = formatterAll.format(inputText);

                            TestTools.expect(actualText, equals(expectedText));
                        }
                    );

                    test('End indented', ()
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
                        }
                    );

                    test('Start and middle indented', ()
                        {
                            const String inputText =
                                'void f()\n'
                                '{\n'
                                '        /*\n'
                                '        *//*\n'
                                '    */\n'
                                '}\n';
                            const String expectedText =
                                'void f()\n'
                                '{\n'
                                '    /*\n'
                                '    *//*\n'
                                '    */\n'
                                '}\n';

                            final String actualText = formatterAll.format(inputText);

                            TestTools.expect(actualText, equals(expectedText));
                        }
                    );

                    test('Start and end indented', ()
                        {
                            const String inputText =
                                'void f()\n'
                                '{\n'
                                '        /*\n'
                                '    *//*\n'
                                '        */\n'
                                '}\n';
                            const String expectedText =
                                'void f()\n'
                                '{\n'
                                '    /*\n'
                                '    *//*\n'
                                '        */\n'
                                '}\n';

                            final String actualText = formatterAll.format(inputText);

                            TestTools.expect(actualText, equals(expectedText));
                        }
                    );

                    test('Middle and end indented', ()
                        {
                            const String inputText =
                                'void f()\n'
                                '{\n'
                                '    /*\n'
                                '        *//*\n'
                                '        */\n'
                                '}\n';
                            const String expectedText =
                                'void f()\n'
                                '{\n'
                                '    /*\n'
                                '        *//*\n'
                                '    */\n'
                                '}\n';

                            final String actualText = formatterAll.format(inputText);

                            TestTools.expect(actualText, equals(expectedText));
                        }
                    );
                }
            );
        }
    );
}
