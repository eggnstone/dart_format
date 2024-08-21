import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config configAll = Config.all();
    final Formatter formatterAll = Formatter(configAll);

    // TODO: Convert to formatter test
    test('Trailing comma after assertion message', ()
        {
            const String inputText = "void f(){assert(true == true,'message',);}";
            const String expectedText = "void f()\n{\n    assert(true == true,'message');\n}\n";

            final String actualText = formatterAll.format(inputText);

            TestTools.expect(actualText, equals(expectedText));
        }
    );
}
