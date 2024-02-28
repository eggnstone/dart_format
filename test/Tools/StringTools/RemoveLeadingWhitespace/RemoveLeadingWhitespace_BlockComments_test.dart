import 'package:dart_format/src/Exceptions/DartFormatException.dart';
import 'package:dart_format/src/Tools/StringTools.dart';
import 'package:test/test.dart';

import '../../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('RemoveLeadingWhitespace (Block Comments)', ()
        {
            final String dummySpace = ' ' * 10;
            final String space4 = ' ' * 4;

            test('Ignore ending block comment when expectComments=false', ()
                {
                    const String inputText = '*/';

                    // ignore: avoid_redundant_argument_values
                    final String actualText = StringTools.removeLeadingWhitespace(inputText, expectComments: false);

                    TestTools.expect(actualText, equals(inputText));
                }
            );

            test('Throw on ending block comment when expectComments=true', ()
                {
                    const String inputText = '*/';

                    void f() => StringTools.removeLeadingWhitespace(inputText, expectComments: true);
                    expect(f, throwsA(isA<DartFormatException>()));
                }
            );

            test('Ignore block comments in double quote strings', ()
                {
                    const String inputText = 'String s = "/*"';

                    final String actualText = StringTools.removeLeadingWhitespace(inputText);

                    TestTools.expect(actualText, equals(inputText));
                }
            );

            test('Exact whitespace as needed, with inner comment', ()
                {
                    final String inputText =
                    '$dummySpace/*START\n'
                    '${space4}/*COMMENT*/\n'
                    'END*/$dummySpace';

                    final String actualText = StringTools.removeLeadingWhitespace(inputText, expectComments: true);

                    TestTools.expect(actualText, equals(inputText));
                }
            );

            test('Exact whitespace as needed, with empty line', ()
                {
                    final String inputText =
                    '$dummySpace/*START\n'
                    '\n'
                    'END*/$dummySpace';

                    final String actualText = StringTools.removeLeadingWhitespace(inputText);

                    TestTools.expect(actualText, equals(inputText));
                }
            );

            test('Exact whitespace as needed, content more indented than end', ()
                {
                    final String inputText =
                    '$dummySpace/*START\n'
                    '${space4}TEXT\n'
                    'END*/$dummySpace';

                    final String actualText = StringTools.removeLeadingWhitespace(inputText, expectComments: true);

                    TestTools.expect(actualText, equals(inputText));
                }
            );

            test('Exact whitespace as needed, content less indented than end', ()
                {
                    final String inputText =
                    '$dummySpace/*START\n'
                    'TEXT\n'
                    '${space4}END*/$dummySpace';

                    final String actualText = StringTools.removeLeadingWhitespace(inputText, expectComments: true);

                    TestTools.expect(actualText, equals(inputText));
                }
            );

            test('More whitespace than needed, with empty line', ()
                {
                    final String inputText =
                    '$dummySpace/*START\n'
                    '\n'
                    '${space4}END*/$dummySpace';
                    final String expectedText =
                    '$dummySpace/*START\n'
                    '\n'
                    'END*/$dummySpace';

                    final String actualText = StringTools.removeLeadingWhitespace(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('More whitespace than needed, content more indented than end', ()
                {
                    final String inputText =
                    '$dummySpace/*START\n'
                    '${space4}${space4}TEXT\n'
                    '${space4}END*/$dummySpace';
                    final String expectedText =
                    '$dummySpace/*START\n'
                    '${space4}TEXT\n'
                    'END*/$dummySpace';

                    final String actualText = StringTools.removeLeadingWhitespace(inputText, expectComments: true);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('More whitespace than needed, content less indented than end', ()
                {
                    final String inputText =
                    '$dummySpace/*START\n'
                    '${space4}TEXT\n'
                    '${space4}${space4}END*/$dummySpace';
                    final String expectedText =
                    '$dummySpace/*START\n'
                    'TEXT\n'
                    '${space4}END*/$dummySpace';

                    final String actualText = StringTools.removeLeadingWhitespace(inputText, expectComments: true);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
