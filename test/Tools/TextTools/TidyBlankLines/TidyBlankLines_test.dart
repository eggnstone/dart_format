import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Tools/TextTools.dart';
import 'package:test/test.dart';

import '../../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final TextTools textTools = TextTools(Config.all());

    group('TextTools.tidyBlankLines: start of file', ()
        {
            test('content without leading blanks is unchanged', ()
                {
                    expect(textTools.tidyBlankLines('A\n'), equals('A\n'));
                }
            );

            test('a single leading blank line is removed', ()
                {
                    expect(textTools.tidyBlankLines('\nA\n'), equals('A\n'));
                }
            );

            test('multiple leading blank lines (including whitespace-only ones) are removed', ()
                {
                    expect(textTools.tidyBlankLines('  \n\t\n\nA\n'), equals('A\n'));
                }
            );
        }
    );

    group('TextTools.tidyBlankLines: end of file', ()
        {
            test('content without trailing blanks is unchanged', ()
                {
                    expect(textTools.tidyBlankLines('A\n'), equals('A\n'));
                }
            );

            test('trailing blank lines are stripped, the final newline is kept', ()
                {
                    expect(textTools.tidyBlankLines('A\n\n\n\n'), equals('A\n'));
                }
            );

            test('trailing whitespace-only lines are removed', ()
                {
                    expect(textTools.tidyBlankLines('A\n  \n\t\n'), equals('A\n'));
                }
            );

            test('content without trailing newline gets one appended (addNewLineAtEndOfText pass)', ()
                {
                    expect(textTools.tidyBlankLines('A'), equals('A\n'));
                }
            );
        }
    );

    group('TextTools.tidyBlankLines: adjacent to braces', ()
        {
            test('text with no blank lines around braces is unchanged', ()
                {
                    const String input = '{\n    A;\n}\n';
                    expect(textTools.tidyBlankLines(input), equals(input));
                }
            );

            test('blank line immediately after the opening brace is removed', ()
                {
                    expect(textTools.tidyBlankLines('{\n\n    A;\n}\n'), equals('{\n    A;\n}\n'));
                }
            );

            test('multiple blank lines after the opening brace are removed', ()
                {
                    expect(textTools.tidyBlankLines('{\n\n\n\n    A;\n}\n'), equals('{\n    A;\n}\n'));
                }
            );

            test('blank line immediately before the closing brace is removed', ()
                {
                    expect(textTools.tidyBlankLines('{\n    A;\n\n}\n'), equals('{\n    A;\n}\n'));
                }
            );

            test('multiple blank lines before the closing brace are removed (brace indent preserved)', ()
                {
                    expect(textTools.tidyBlankLines('{\n    A;\n\n\n    }\n'), equals('{\n    A;\n    }\n'));
                }
            );

            test('blank lines around both braces are removed', ()
                {
                    expect(textTools.tidyBlankLines('{\n\n    A;\n\n}\n'), equals('{\n    A;\n}\n'));
                }
            );

            test('nested braces each lose their adjacent blank lines', ()
                {
                    expect(
                        textTools.tidyBlankLines('{\n\n    {\n\n        A;\n\n    }\n\n}\n'),
                        equals('{\n    {\n        A;\n    }\n}\n')
                    );
                }
            );
        }
    );

    group('TextTools.tidyBlankLines: gating', ()
        {
            test('returns input unchanged when maxEmptyLines is -1', ()
                {
                    final TextTools off = TextTools(Config.all(maxEmptyLines: -1));
                    const String input = '\n\n{\n\n    A;\n\n}\n\n';
                    expect(off.tidyBlankLines(input), equals(input));
                }
            );
        }
    );
}
