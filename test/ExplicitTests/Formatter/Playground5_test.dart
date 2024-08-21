import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:dart_format/src/LeadingWhitespaceRemover.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config configAll = Config.all();
    final Formatter formatterAll = Formatter(configAll);

    group('Playground 5', ()
        {
            test("format: Text in 3x'", ()
                {
                    const String inputText =
                        'String s =\n'
                        "'''\n"
                        'ab\n'
                        "''';\n";
                    const String expectedText =
                        'String s =\n'
                        "    '''\n"
                        'ab\n'
                        "''';\n";

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test(r"format: ${} in 3x'", ()
                {
                    const String inputText =
                        'bool b = true;\n'
                        "String s = ''' \${b ? '''2''' : '''3'''}\n"
                        "''';\n";
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test(r"format: ${} with // in 3x'", ()
                {
                    const String inputText =
                        'bool b = true;\n'
                        "String s = ''' \${b ? '''2''' : '''3//'''}\n"
                        "''';\n";
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test("format: ' in 3x'", ()
                {
                    const String inputText =
                        'String s =\n'
                        "'''\n"
                        "a'b\n"
                        "''';\n";
                    const String expectedText =
                        'String s =\n'
                        "    '''\n"
                        "a'b\n"
                        "''';\n";

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('format: " in 3x"', ()
                {
                    const String inputText =
                        'String s =\n'
                        '"""\n'
                        'a"b\n'
                        '""";\n';
                    const String expectedText =
                        'String s =\n'
                        '    """\n'
                        'a"b\n'
                        '""";\n';

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test("removeFrom: Text in 3x'", ()
                {
                    const String inputText =
                        "'''\n"
                        'ab\n'
                        "''';\n";
                    const String expectedText = inputText;

                    final String actualText = LeadingWhitespaceRemover.removeFrom(inputText, removeLeadingSpaces: false);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test("removeFrom: ' in 3x'", ()
                {
                    const String inputText =
                        "'''\n"
                        "a'b\n"
                        "'''\n";
                    const String expectedText = inputText;

                    final String actualText = LeadingWhitespaceRemover.removeFrom(inputText, removeLeadingSpaces: false);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('removeFrom: " in 3x"', ()
                {
                    const String inputText =
                        '"""\n'
                        'a"b\n'
                        '"""\n';
                    const String expectedText = inputText;

                    final String actualText = LeadingWhitespaceRemover.removeFrom(inputText, removeLeadingSpaces: false);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('format: triple single-quote string with interpolation', ()
                {
                    const String inputText = "String s = '''\${true ? '''a''' : '''b'''}''';\n";
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('format: triple single-quote string with interpolation start/end', ()
                {
                    const String inputText = "String s = '''start\${true ? '''a''' : '''b'''}end''';\n";
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('format: triple single-quote string with interpolation start/end 2', ()
                {
                    const String inputText = "String s = '''start1\nstart2\n\${true ? '''a''' : '''b'''}\nend1\nend2''';\n";
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('format: triple single-quote string with interpolation start/end 2 with spaces', ()
                {
                    const String inputText = "String s = \n    '''start1\n    start2\n    \${true ? '''a''' : '''b'''}\n    end1\n    end2''';\n";
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('format: triple single-quote string with interpolation start/end 2 with spaces with strings', ()
                {
                    const String inputText = "String s = \n    'A'\n    '''start1\n    start2\n    \${true ? '''a''' : '''b'''}\n    end1\n    end2'''\n    'B';\n";
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('format: single-quote string with interpolation with comments', ()
                {
                    const String inputText = "String s = /*Comment1*/'start\${true ? 'a' : 'b'}end';/*Comment2*/\n";
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('format: triple single-quote string with interpolation with }', ()
                {
                    const String inputText = "String s = '''\${true ? '''}''' : '''}'''}''';\n";
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('format: single-quote string', ()
                {
                    const String inputText = "String s = \n    'A';\n";
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('format: triple single-quote string', ()
                {
                    const String inputText = "String s = \n    '''start\n    end''';\n";
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('format: single-quote string with value', ()
                {
                    const String inputText = "String s = 'start\${X}end';\n";
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('format: triple single-quote string with value', ()
                {
                    const String inputText = "String s = '''start\${X}end''';\n";
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('format: single-quote string with block comment start', ()
                {
                    const String inputText = "String s = '\$a/*';\n";
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
