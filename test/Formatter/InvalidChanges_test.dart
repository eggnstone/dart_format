import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config configAll = Config.all();
    final Formatter formatterAll = Formatter(configAll);

    test('Euro sign must not be changed to question mark', ()
        {
            const String inputText = "String euro='€';\n";
            const String expectedText = inputText;

            final String actualText = formatterAll.format(inputText);

            TestTools.expect(actualText, equals(expectedText));
        }
    );
}
