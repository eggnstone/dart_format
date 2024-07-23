import 'package:dart_format/src/Tools/CommentTools.dart';
import 'package:test/test.dart';

import '../../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('CommentTools', ()
        {
            group('isEmptyOrComments', ()
                {
                    test('Empty text', ()
                        {
                            const String inputText = '';
                            const bool expectedResult = true;

                            final bool actualResult = CommentTools.isEmptyOrComments(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    test('Single space', ()
                        {
                            const String inputText = ' ';
                            const bool expectedResult = true;

                            final bool actualResult = CommentTools.isEmptyOrComments(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    test('Single letter', ()
                        {
                            const String inputText = 'a';
                            const bool expectedResult = false;

                            final bool actualResult = CommentTools.isEmptyOrComments(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    test('Single newline', ()
                        {
                            const String inputText = '\n';
                            const bool expectedResult = true;

                            final bool actualResult = CommentTools.isEmptyOrComments(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    test('Line comment', ()
                        {
                            const String inputText = '//Comment';
                            const bool expectedResult = true;

                            final bool actualResult = CommentTools.isEmptyOrComments(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    test('Block comment', ()
                        {
                            const String inputText = '/*Comment*/';
                            const bool expectedResult = true;

                            final bool actualResult = CommentTools.isEmptyOrComments(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    test('2 block comments back-to-back with line breaks', ()
                        {
                            const String inputText = '/*Comment\n1*//*Comment\n2*/';
                            const bool expectedResult = true;

                            final bool actualResult = CommentTools.isEmptyOrComments(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    test('Nested block comments', ()
                        {
                            const String inputText = '/*a/*b*/c*/';
                            const bool expectedResult = true;

                            final bool actualResult = CommentTools.isEmptyOrComments(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    test('Unfinished block comment: /*', ()
                        {
                            const String inputText = '/*';
                            const bool expectedResult = false;

                            final bool actualResult = CommentTools.isEmptyOrComments(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    test('Unfinished block comment: /**', ()
                        {
                            const String inputText = '/**';
                            const bool expectedResult = false;

                            final bool actualResult = CommentTools.isEmptyOrComments(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    test('Unfinished block comment: /*a', ()
                        {
                            const String inputText = '/*a';
                            const bool expectedResult = false;

                            final bool actualResult = CommentTools.isEmptyOrComments(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    test('Unfinished block comment: /*a*', ()
                        {
                            const String inputText = '/*a*';
                            const bool expectedResult = false;

                            final bool actualResult = CommentTools.isEmptyOrComments(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    test('More closed than opened block comments', ()
                        {
                            const String inputText = '/*Comment*/*/';
                            const bool expectedResult = false;

                            final bool actualResult = CommentTools.isEmptyOrComments(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );
                }
            );
        }
    );
}
