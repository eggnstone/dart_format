import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../../../../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config configNone = Config.none();
    final Formatter formatterNone = Formatter(configNone);

    group('ForStatements', ()
        {
            test('Simple for statement', ()
                {
                    const String inputText = 'void f(){for(;;);}';
                    const String expectedText = 'void f(){for(;;);}';

                    final String actualText = formatterNone.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
