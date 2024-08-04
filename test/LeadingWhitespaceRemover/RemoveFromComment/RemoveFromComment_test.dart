import 'package:dart_format/src/Constants/Constants.dart';
import 'package:dart_format/src/LeadingWhitespaceRemover.dart';
import 'package:dart_format/src/Tools/LogTools.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('LeadingWhitespaceRemover.removeFromComment', ()
        {
            test('Empty', ()
                {
                    const String currentLineSoFar = '';
                    const String inputText = '';
                    const String expectedText = inputText;

                    final String actualText = LeadingWhitespaceRemover.removeFromComment(currentLineSoFar, inputText, '');

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Leading spaces+text, single line block comment', ()
                {
                    const String currentLineSoFar = '    TEXT';
                    const String inputText = '/**/';
                    const String expectedText = inputText;

                    final String actualText = LeadingWhitespaceRemover.removeFromComment(currentLineSoFar, inputText, '');

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Leading spaces+text+space, single line block comment', ()
                {
                    const String currentLineSoFar = '    TEXT ';
                    const String inputText = '/**/';
                    const String expectedText = inputText;

                    final String actualText = LeadingWhitespaceRemover.removeFromComment(currentLineSoFar, inputText, '');

                    logDebug('currentLineSoFar:\n$currentLineSoFar');
                    logDebug('inputText:\n$inputText');
                    logDebug('actualText:\n$actualText');
                    logDebug('expectedText:\n$expectedText');

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Leading spaces+text, multiline block comment', ()
                {
                    const String currentLineSoFar = '    TEXT';
                    const String inputText = '/*\n*/';
                    const String expectedText = '${Constants.INDENT_START}8${Constants.INDENT_END}/*\n${Constants.INDENT_START}0${Constants.INDENT_END}*/';

                    final String actualText = LeadingWhitespaceRemover.removeFromComment(currentLineSoFar, inputText, '');

                    logDebug('currentLineSoFar:\n$currentLineSoFar');
                    logDebug('inputText:\n$inputText');
                    logDebug('actualText:\n$actualText');
                    logDebug('expectedText:\n$expectedText');

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Leading spaces+text, multiline block comment', ()
                {
                    const String currentLineSoFar = '    TEXT';
                    const String inputText = '/*\n*/';
                    const String expectedText = '${Constants.INDENT_START}8${Constants.INDENT_END}/*\n${Constants.INDENT_START}0${Constants.INDENT_END}*/';

                    final String actualText = LeadingWhitespaceRemover.removeFromComment(currentLineSoFar, inputText, '');

                    logDebug('currentLineSoFar:\n$currentLineSoFar');
                    logDebug('inputText:\n$inputText');
                    logDebug('actualText:\n$actualText');
                    logDebug('expectedText:\n$expectedText');

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Leading spaces+text+space, multiline block comment', ()
                {
                    const String currentLineSoFar = '    TEXT ';
                    const String inputText = '/*\n*/';
                    const String expectedText = '${Constants.INDENT_START}009${Constants.INDENT_END}/*\n${Constants.INDENT_START}0${Constants.INDENT_END}*/';

                    final String actualText = LeadingWhitespaceRemover.removeFromComment(currentLineSoFar, inputText, '');

                    logDebug('currentLineSoFar:\n$currentLineSoFar');
                    logDebug('inputText:\n$inputText');
                    logDebug('actualText:\n$actualText');
                    logDebug('expectedText:\n$expectedText');

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Leading spaces+text+space, multiline block comment, second line has leading spaces', ()
                {
                    const String currentLineSoFar = '    TEXT';
                    const String inputText = '/*a\n    b*/';
                    const String expectedText = '${Constants.INDENT_START}8${Constants.INDENT_END}/*a\n${Constants.INDENT_START}4${Constants.INDENT_END}b*/';

                    final String actualText = LeadingWhitespaceRemover.removeFromComment(currentLineSoFar, inputText, '');

                    logDebug('currentLineSoFar:\n$currentLineSoFar');
                    logDebug('inputText:\n$inputText');
                    logDebug('actualText:\n$actualText');
                    logDebug('expectedText:\n$expectedText');

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
