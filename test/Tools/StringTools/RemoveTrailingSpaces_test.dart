import 'package:dart_format/src/Tools/StringTools.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('StringTools.removeTrailingSpaces', ()
        {
            test('Empty text', ()
                {
                    const String inputText = '';
                    const String expectedText = inputText;

                    final String actualText = StringTools.removeTrailingSpaces(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('No space at the end', ()
                {
                    const String inputText = 'No space at the end';
                    const String expectedText = inputText;

                    final String actualText = StringTools.removeTrailingSpaces(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Single space at the end', ()
                {
                    const String expectedText = 'Single space at the end';
                    const String inputText = '$expectedText ';

                    final String actualText = StringTools.removeTrailingSpaces(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Multiple spaces at the end', ()
                {
                    const String expectedText = 'Multiple spaces at the end';
                    const String inputText = '$expectedText  ';

                    final String actualText = StringTools.removeTrailingSpaces(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Single space after line break', ()
                {
                    const String expectedText = 'Single space after line break \n';
                    const String inputText = '$expectedText ';

                    final String actualText = StringTools.removeTrailingSpaces(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
