import 'package:dart_format/dart_format.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config configNone = Config.none();
    final Formatter formatterNone = Formatter(configNone);

    group('Comments', ()
        {
                        /* Unterminated multi-line comment.
                        test('Block comment with block comment start inside', ()
                        {
                            // ignore: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation
                            const String inputText = '/' + '* Comment /' + '* *' + '/';
                            const String expectedText = inputText;

                            final String actualText = formatterNone.format(inputText);

                            TestTools.expect(actualText, equals(expectedText));
                        }
                        );*/

            test('Block comment start in single-quote string', ()
                {
                    const String inputText = "String s = '/*';";
                    const String expectedText = inputText;

                    final String actualText = formatterNone.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Block comment start in double-quote string', ()
                {
                    const String inputText = 'String s = "/*";';
                    const String expectedText = inputText;

                    final String actualText = formatterNone.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('EndOfLine comment in single-quote string', ()
                {
                    const String inputText = "String s = '//';";
                    const String expectedText = inputText;

                    final String actualText = formatterNone.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('EndOfLine comment in double-quote string', ()
                {
                    const String inputText = 'String s = "//";';
                    const String expectedText = inputText;

                    final String actualText = formatterNone.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Block comment with block comment inside', ()
                {
                    const String inputText = '/* Comment /* */ */';
                    const String expectedText = inputText;

                    final String actualText = formatterNone.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Block comment with EndOfLine comment inside', ()
                {
                    const String inputText = '/* Comment // */';
                    const String expectedText = inputText;

                    final String actualText = formatterNone.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('EndOfLine comment with Block comment start inside', ()
                {
                    const String inputText = '// /* Comment';
                    const String expectedText = inputText;

                    final String actualText = formatterNone.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Normal comments and DocComments mixed', ()
                {
                    const String inputText =
                        'class C\n'
                        '{\n'
                        '/// DocCommentOnly\n'
                        'bool docCommentOnly = true;\n'
                        '// NormalCommentOnly\n'
                        'bool normalCommentOnly = true;\n'
                        '/// DocComment1\n'
                        '// NormalComment2\n'
                        'bool docFirstThenNormal = true;\n'
                        '// NormalComment1\n'
                        '/// DocComment2\n'
                        'bool normalFirstThenDoc = true;\n'
                        '}';
                    const String expectedText = inputText;

                    final String actualText = formatterNone.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('DocComment with reference', ()
                {
                    const String inputText =
                        'class C\n'
                        '{\n'
                        '/// Start [SomeReference] End\n'
                        'bool b = true;\n'
                        '}';
                    const String expectedText = inputText;

                    final String actualText = formatterNone.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
