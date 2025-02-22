import 'package:dart_format/src/Tools/CommentTools.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('CommentTools', ()
        {
            group('removeComments', ()
                {
                    test('Empty text', ()
                        {
                            const String inputText = '';
                            const String expectedResult = '';

                            final String actualResult = CommentTools.removeComments(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    test('Single space', ()
                        {
                            const String inputText = ' ';
                            const String expectedResult = ' ';

                            final String actualResult = CommentTools.removeComments(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    test('Single letter', ()
                        {
                            const String inputText = 'a';
                            const String expectedResult = 'a';

                            final String actualResult = CommentTools.removeComments(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    test('Single newline', ()
                        {
                            const String inputText = '\n';
                            const String expectedResult = '\n';

                            final String actualResult = CommentTools.removeComments(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    test('Line comment', ()
                        {
                            const String inputText = '//Comment';
                            const String expectedResult = '';

                            final String actualResult = CommentTools.removeComments(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    test('Text and line comment', ()
                        {
                            const String inputText = 'a//Comment';
                            const String expectedResult = 'a';

                            final String actualResult = CommentTools.removeComments(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    test('Line comment with new line', ()
                        {
                            const String inputText = '//Comment\n';
                            const String expectedResult = '\n';

                            final String actualResult = CommentTools.removeComments(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    test('Line comment with new line and text', ()
                        {
                            const String inputText = '//Comment\ntext';
                            const String expectedResult = '\ntext';

                            final String actualResult = CommentTools.removeComments(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    test('Block comment', ()
                        {
                            const String inputText = '/*Comment*/';
                            const String expectedResult = '';

                            final String actualResult = CommentTools.removeComments(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    test('2 block comments back-to-back with line breaks', ()
                        {
                            const String inputText = '/*Comment\n1*//*Comment\n2*/';
                            const String expectedResult = '';

                            final String actualResult = CommentTools.removeComments(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    test('Nested block comments', ()
                        {
                            const String inputText = '/*a/*b*/c*/';
                            const String expectedResult = '';

                            final String actualResult = CommentTools.removeComments(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    group('Invalid input', ()
                        {
                            test('Unfinished block comment: /*', ()
                                {
                                    const String inputText = '/*';
                                    const String expectedResult = inputText;

                                    final String actualResult = CommentTools.removeComments(inputText);

                                    expect(actualResult, equals(expectedResult));
                                }
                            );

                            test('Unfinished block comment: /**', ()
                                {
                                    const String inputText = '/**';
                                    const String expectedResult = inputText;

                                    final String actualResult = CommentTools.removeComments(inputText);

                                    expect(actualResult, equals(expectedResult));
                                }
                            );

                            test('Unfinished block comment: /*a', ()
                                {
                                    const String inputText = '/*a';
                                    const String expectedResult = inputText;

                                    final String actualResult = CommentTools.removeComments(inputText);

                                    expect(actualResult, equals(expectedResult));
                                }
                            );

                            test('Unfinished block comment: /*a*', ()
                                {
                                    const String inputText = '/*a*';
                                    const String expectedResult = inputText;

                                    final String actualResult = CommentTools.removeComments(inputText);

                                    expect(actualResult, equals(expectedResult));
                                }
                            );

                            test('More closed than opened block comments', ()
                                {
                                    const String inputText = '/*Comment*/*/';
                                    const String expectedResult = inputText;

                                    final String actualResult = CommentTools.removeComments(inputText);

                                    expect(actualResult, equals(expectedResult));
                                }
                            );
                        }
                    );
                }
            );
        }
    );
}
