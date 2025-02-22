import 'package:dart_format/src/Tools/FormatTools.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('FormatTools', ()
        {
            group('isCommaText', ()
                {
                    test('Empty text', ()
                        {
                            const String inputText = '';
                            const bool expectedResult = false;

                            final bool actualResult = FormatTools.isCommaText(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    test('Simple comma', ()
                        {
                            const String inputText = ',';
                            const bool expectedResult = true;

                            final bool actualResult = FormatTools.isCommaText(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    test('Comma surrounded by spaces and line breaks', ()
                        {
                            const String inputText = '\n , \n';
                            const bool expectedResult = true;

                            final bool actualResult = FormatTools.isCommaText(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    test('Comma surrounded by comments', ()
                        {
                            const String inputText = '//Comment1\n/*Comment2*/,//Comment3\n/*Comment4*/';
                            const bool expectedResult = true;

                            final bool actualResult = FormatTools.isCommaText(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    test('Comma in comment', ()
                        {
                            const String inputText = '/*,*/';
                            const bool expectedResult = false;

                            final bool actualResult = FormatTools.isCommaText(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    test('Comma before comment', ()
                        {
                            const String inputText = ',/*,*/';
                            const bool expectedResult = true;

                            final bool actualResult = FormatTools.isCommaText(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    test('Comma after comment', ()
                        {
                            const String inputText = '/*,*/,';
                            const bool expectedResult = true;

                            final bool actualResult = FormatTools.isCommaText(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    test('Comma surrounded by comments with commas', ()
                        {
                            const String inputText = '/*,*/,/*,*/';
                            const bool expectedResult = true;

                            final bool actualResult = FormatTools.isCommaText(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );
                }
            );
        }
    );
}
