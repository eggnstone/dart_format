import 'package:dart_format/src/Constants/Constants.dart';
import 'package:dart_format/src/Tools/FormatTools.dart';
import 'package:test/test.dart';

import '../../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('FormatTools', ()
        {
            group('RemoveIndents', ()
                {
                    test('Empty text', ()
                        {
                            const String inputText = '';
                            const String expectedResult = inputText;

                            final String actualResult = FormatTools.removeIndentTags(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    test('Simple text', ()
                        {
                            const String inputText = 'Simple text.';
                            const String expectedResult = inputText;

                            final String actualResult = FormatTools.removeIndentTags(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );

                    test('Indent removed', ()
                        {
                            const String inputText = 'StartText${Constants.INDENT_START}INDENT${Constants.INDENT_END}EndText';
                            const String expectedResult = 'StartTextEndText';

                            final String actualResult = FormatTools.removeIndentTags(inputText);

                            expect(actualResult, equals(expectedResult));
                        }
                    );
                }
            );
        }
    );
}
