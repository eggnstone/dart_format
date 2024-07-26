import 'package:dart_format/dart_format.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    // TODO: Convert to formatter test
    test('Trailing comma after assertion message', ()
        {
            const String inputText = "void f(){assert(true == true,'message',);}";
            const String expectedText = "void f()\n{\n    assert(true == true,'message');\n}\n";

            final Config config = Config.all();
            final Formatter formatter = Formatter(config);
            final String actualText = formatter.format(inputText);

            TestTools.expect(actualText, equals(expectedText));
        }
    );
}
