import 'package:dart_format/src/Constants/Constants.dart';
import 'package:dart_format/src/Tools/FormatTools.dart';
import 'package:test/test.dart';

import '../../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('FormatTools', ()
        {
            group('ResolveIndents', ()
                {
                    test('Empty text', ()
                        {
                            const String inputText = '';
                            const String expectedResult = inputText;

                            final String actualResult = FormatTools.resolveIndents(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    test('Text without tags', ()
                        {
                            const String inputText = 'Some text';
                            const String expectedResult = inputText;

                            final String actualResult = FormatTools.resolveIndents(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    /*test('Zero indent throws', ()
                        {
                            const String inputText = '${Constants.INDENT_START}0${Constants.INDENT_END}Some text';

                            expect(() => FormatTools.resolveIndents(inputText), throwsA(isA<Exception>()));
                        }
                    );*/

                    test('Negative indent throws', ()
                        {
                            const String inputText = '${Constants.INDENT_START}-4${Constants.INDENT_END}Some text';

                            expect(() => FormatTools.resolveIndents(inputText), throwsA(isA<Exception>()));
                        }
                    );

                    test('Indent completely applied', ()
                        {
                            const String inputText = '${Constants.INDENT_START}4${Constants.INDENT_END}Some text';
                            const String expectedResult = '    Some text';

                            final String actualResult = FormatTools.resolveIndents(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    test('Indent partially applied', ()
                        {
                            const String inputText = '  ${Constants.INDENT_START}4${Constants.INDENT_END}Some text';
                            const String expectedResult = '    Some text';

                            final String actualResult = FormatTools.resolveIndents(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    test('Indent not necessary', ()
                        {
                            const String inputText = '    ${Constants.INDENT_START}4${Constants.INDENT_END}Some text';
                            const String expectedResult = '    Some text';

                            final String actualResult = FormatTools.resolveIndents(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    test('Indent cannot be applied', ()
                        {
                            const String inputText = '12345678${Constants.INDENT_START}4${Constants.INDENT_END}Some text';
                            const String expectedResult = '12345678Some text';

                            final String actualResult = FormatTools.resolveIndents(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    test('Second indent applied', ()
                    {
                        const String inputText = '${Constants.INDENT_START}4${Constants.INDENT_END}Text1${Constants.INDENT_START}10${Constants.INDENT_END}Text2';
                        const String expectedResult = '    Text1 Text2';

                        final String actualResult = FormatTools.resolveIndents(inputText);

                        expect(actualResult, equals(expectedResult));
                    }
                    );


                    test('Second indent cannot be applied', ()
                    {
                        const String inputText = '${Constants.INDENT_START}4${Constants.INDENT_END}Text1${Constants.INDENT_START}4${Constants.INDENT_END}Text2';
                        const String expectedResult = '    Text1Text2';

                        final String actualResult = FormatTools.resolveIndents(inputText);

                        expect(actualResult, equals(expectedResult));
                    }
                    );

                    test('Reducing temporary indentation', ()
                    {
                        const String inputText = '    ${Constants.INDENT_START}0${Constants.INDENT_END}Some text';
                        const String expectedResult = 'Some text';

                        final String actualResult = FormatTools.resolveIndents(inputText);

                        expect(actualResult, equals(expectedResult));
                    }
                    );

                    test('x without detected space', ()
                    {
                        const String inputText = 'START${Constants.INDENT_START}2${Constants.INDENT_END}END';
                        const String expectedResult = 'START''END';

                        final String actualResult = FormatTools.resolveIndents(inputText);

                        expect(actualResult, equals(expectedResult));
                    }
                    );

                    test('x with detected space', ()
                    {
                        const String inputText = 'START${Constants.INDENT_START}002${Constants.INDENT_END}END';
                        const String expectedResult = 'START END';

                        final String actualResult = FormatTools.resolveIndents(inputText);

                        expect(actualResult, equals(expectedResult));
                    }
                    );

                    test('x with detected space 2', ()
                    {
                        const String inputText = 'START    ${Constants.INDENT_START}002${Constants.INDENT_END}END';
                        const String expectedResult = 'START END';

                        final String actualResult = FormatTools.resolveIndents(inputText);

                        expect(actualResult, equals(expectedResult));
                    }
                    );
                }
            );
        }
    );
}
