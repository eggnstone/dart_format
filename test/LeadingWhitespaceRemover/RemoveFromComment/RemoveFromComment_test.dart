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
                    const String expectedText = '';

                    final String actualText = LeadingWhitespaceRemover.removeFromComment(currentLineSoFar, inputText, '');

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Leading block comment, single line block comment', ()
                {
                    const String currentLineSoFar = '    */';
                    const String inputText = '/**/';
                    const String expectedText = '/**/';

                    final String actualText = LeadingWhitespaceRemover.removeFromComment(currentLineSoFar, inputText, '');

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Leading block comment, single line block comment 2', ()
                {
                    const String currentLineSoFar = '    */ ';
                    const String inputText = '/**/';
                    const String expectedText = '/**/';

                    final String actualText = LeadingWhitespaceRemover.removeFromComment(currentLineSoFar, inputText, '');

                    logDebug('currentLineSoFar:\n$currentLineSoFar');
                    logDebug('inputText:\n$inputText');
                    logDebug('actualText:\n$actualText');
                    logDebug('expectedText:\n$expectedText');

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Leading block comment, multiline block comment', ()
                {
                    const String currentLineSoFar = '    */';
                    const String inputText = '/*\n*/';
                    const String expectedText = '/*\n*/';

                    final String actualText = LeadingWhitespaceRemover.removeFromComment(currentLineSoFar, inputText, '');

                    logDebug('currentLineSoFar:\n$currentLineSoFar');
                    logDebug('inputText:\n$inputText');
                    logDebug('actualText:\n$actualText');
                    logDebug('expectedText:\n$expectedText');

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            // TODO: Replace all "leading block comment" with "leading spaces+text" if possible.
            test('Leading spaces+text, multiline block comment', ()
                {
                    const String currentLineSoFar = '    TEXT';
                    const String inputText = '/*\n*/';
                    const String expectedText = '/*\n*/';

                    final String actualText = LeadingWhitespaceRemover.removeFromComment(currentLineSoFar, inputText, '');

                    logDebug('currentLineSoFar:\n$currentLineSoFar');
                    logDebug('inputText:\n$inputText');
                    logDebug('actualText:\n$actualText');
                    logDebug('expectedText:\n$expectedText');

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Leading block comment, multiline block comment 2', ()
                {
                    const String currentLineSoFar = '    */ ';
                    const String inputText = '/*\n*/';
                    const String expectedText = '/*\n*/';

                    final String actualText = LeadingWhitespaceRemover.removeFromComment(currentLineSoFar, inputText, '');

                    logDebug('currentLineSoFar:\n$currentLineSoFar');
                    logDebug('inputText:\n$inputText');
                    logDebug('actualText:\n$actualText');
                    logDebug('expectedText:\n$expectedText');

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('TODO: proper name', ()
                {
                    const String currentLineSoFar = '    TEXT';
                    const String inputText = '/*\n    */';
                    const String expectedText = '/*\n*/';

                    final String actualText = LeadingWhitespaceRemover.removeFromComment(currentLineSoFar, inputText, '');

                    logDebug('currentLineSoFar:\n$currentLineSoFar');
                    logDebug('inputText:\n$inputText');
                    logDebug('actualText:\n$actualText');
                    logDebug('expectedText:\n$expectedText');

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('TODO: proper name 2', ()
                {
                    const String currentLineSoFar = '    */';
                    const String inputText = '/*\n    */';
                    const String expectedText = '/*\n*/';

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
