import 'package:dart_format/src/LeadingWhitespaceRemover.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('LeadingWhitespaceRemover.removeFromNonComment', ()
        {
            test('Empty', ()
                {
                    const String inputText = '';
                    const String expectedText = '';

                    final String actualText = LeadingWhitespaceRemover.removeFromNonComment(inputText, '');

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
