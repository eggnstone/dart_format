import 'package:dart_format/dart_format.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    test('ExpressionStatement and PropertyAccess', ()
        {
            const String inputText = 'void f()\n{\n    a\n        ..b;\n}\n';
            const String expectedText = inputText;

            final Config config = Config.all();
            final Formatter formatter = Formatter(config);
            final String actualText = formatter.format(inputText);

            TestTools.expect(actualText, equals(expectedText));
        }
    );
}
