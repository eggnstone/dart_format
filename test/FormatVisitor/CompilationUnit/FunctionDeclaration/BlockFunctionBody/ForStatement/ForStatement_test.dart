import 'package:dart_format/dart_format.dart';
import 'package:test/test.dart';

import '../../../../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    const Config config = Config.none();
    final Formatter formatter = Formatter(config);

    group('ForStatements', ()
        {
            test('Simple for statement', ()
                {
                    const String inputText = 'void f(){for(;;);}';
                    const String expectedText = 'void f(){for(;;);}';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
