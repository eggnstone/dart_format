import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart' as AnalyzerUtilities; // ignore: library_prefixes
import 'package:analyzer/dart/ast/token.dart';
import 'package:dart_format/src/Constants/Constants.dart';
import 'package:dart_format/src/FormatState.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('FormatState', ()
        {
            // TODO: better tests, tests with non-;
            test('addNewLineAfterToken with ;', ()
                {
                    const String inputText = 'int i=0;int j=0;';
                    final Token inputToken1 = Token(TokenType.STRING, 0);
                    final Token inputToken2 = Token(TokenType.SEMICOLON, 6);
                    final Token inputToken3 = Token(TokenType.STRING, 7);
                    final Token inputToken4 = Token(TokenType.SEMICOLON, 14);
                    inputToken1.next = inputToken2;
                    inputToken2.next = inputToken3;
                    inputToken3.next = inputToken4;

                    final ParseStringResult parseResult = AnalyzerUtilities.parseString(content: inputText);
                    final DateTime startDateTime = DateTime.now();
                    final DateTime maxDateTime = startDateTime.add(const Duration(seconds: Constants.MAX_FORMAT_TIME_IN_SECONDS_FOR_TESTS));
                    final FormatState formatState = FormatState(
                        parseResult,
                        indentationSpacesPerLevel: 4,
                        maxDateTime: maxDateTime,
                        removeTrailingCommas: true,
                        startDateTime: startDateTime
                    );

                    formatState.addText('int i=0', 'SOURCE');
                    TestTools.expect(formatState.getResult(), equals('int i=0'));

                    formatState.addText(';', 'SOURCE');
                    TestTools.expect(formatState.getResult(), equals('int i=0;'));

                    formatState.addNewLineAfterToken(inputToken1, 'SOURCE', add: true);
                    TestTools.expect(formatState.getResult(), equals('int i=0;'));

                    formatState.addText('int j=0', 'SOURCE');
                    TestTools.expect(formatState.getResult(), equals('int i=0;int j=0'));

                    formatState.addText(';', 'SOURCE');
                    TestTools.expect(formatState.getResult(), equals('int i=0;int j=0;'));

                    formatState.addNewLineAfterToken(inputToken3, 'SOURCE', add: true);
                    TestTools.expect(formatState.getResult(), equals('int i=0;int j=0;'));
                }
            );

            // TODO: better tests, tests with non-,
            test('addNewLineAfterToken with ,', ()
                {
                    const String inputText = 'void f(void Function()g,int i){}void h(){f((){},0);}';
                    final Token inputToken1 = Token(TokenType.STRING, 0);
                    final Token inputToken2 = Token(TokenType.COMMA, 47);
                    final Token inputToken3 = Token(TokenType.STRING, 48);
                    inputToken1.next = inputToken2;
                    inputToken2.next = inputToken3;

                    final ParseStringResult parseResult = AnalyzerUtilities.parseString(content: inputText);
                    final DateTime startDateTime = DateTime.now();
                    final DateTime maxDateTime = startDateTime.add(const Duration(seconds: Constants.MAX_FORMAT_TIME_IN_SECONDS_FOR_TESTS));
                    final FormatState formatState = FormatState(
                        parseResult,
                        indentationSpacesPerLevel: 4,
                        maxDateTime: maxDateTime,
                        removeTrailingCommas: false,
                        startDateTime: startDateTime
                    );

                    formatState.addText('void f(void Function()g,int i){}void h(){f((){}', 'SOURCE');
                    TestTools.expect(formatState.getResult(), equals('void f(void Function()g,int i){}void h(){f((){}'));

                    formatState.addText(',', 'SOURCE');
                    TestTools.expect(formatState.getResult(), equals('void f(void Function()g,int i){}void h(){f((){},'));

                    formatState.addNewLineAfterToken(inputToken1, 'SOURCE', add: true);
                    TestTools.expect(formatState.getResult(), equals('void f(void Function()g,int i){}void h(){f((){},'));

                    formatState.addText('0);}', 'SOURCE');
                    TestTools.expect(formatState.getResult(), equals('void f(void Function()g,int i){}void h(){f((){},0);}'));
                }
            );
        }
    );
}
