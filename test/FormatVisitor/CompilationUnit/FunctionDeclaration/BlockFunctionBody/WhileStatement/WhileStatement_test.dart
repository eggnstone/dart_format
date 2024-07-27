import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../../../../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config config = Config.none();
    final Formatter formatter = Formatter(config);

    group('WhileStatements', ()
        {
            test('Simple while statement', ()
                {
                    const String inputText = 'void f(){while(true);}';
                    const String expectedText = 'void f(){while(true);}';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
