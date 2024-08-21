import 'package:dart_format/src/Constants/Constants.dart';
import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:dart_format/src/LeadingWhitespaceRemover.dart';
import 'package:dart_format/src/Tools/FormatTools.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config configAll = Config.all();
    final Formatter formatterAll = Formatter(configAll);

    group('Playground 4e', ()
        {
            test('Indentation', ()
                {
                    const String inputText =
                        '/*a\n'
                        '    b*//*c\n'
                        '        d*/\n';
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('Indentation 2', ()
                {
                    const String currentLineSoFar = '  TEXT';
                    const String s =
                        '/*c\n'
                        '        d*/';
                    const String expectedText =
                        '      /*c\n'
                        '        d*/';

                    final String actualText = FormatTools.resolveIndents(LeadingWhitespaceRemover.removeFromComment(currentLineSoFar, s, ''));

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Indentation 2a', ()
                {
                    const String currentLineSoFar = '  TEXT';
                    const String inputText =
                        '/*c\n'
                        '        d*/';
                    const String expectedText =
                        '${Constants.INDENT_START}6${Constants.INDENT_END}/*c\n'
                        '${Constants.INDENT_START}8${Constants.INDENT_END}d*/';

                    final String actualText = LeadingWhitespaceRemover.removeFromComment(currentLineSoFar, inputText, '');

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Indentation 2b', ()
                {
                    const String inputText =
                        '${Constants.INDENT_START}6${Constants.INDENT_END}/*c\n'
                        '${Constants.INDENT_START}8${Constants.INDENT_END}d*/';
                    const String expectedText =
                        '      /*c\n'
                        '        d*/';

                    final String actualText = FormatTools.resolveIndents(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
