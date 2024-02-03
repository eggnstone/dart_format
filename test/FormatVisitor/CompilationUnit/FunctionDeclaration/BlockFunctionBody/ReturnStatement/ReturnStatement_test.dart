import 'package:dart_format/dart_format.dart';
import 'package:test/test.dart';

import '../../../../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    const Config config = Config.none();
    final Formatter formatter = Formatter(config);

    group('ReturnStatements', ()
        {
            test('Simple return statement', ()
                {
                    const String inputText = 'void f(){return;}';
                    const String expectedText = 'void f(){return;}';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
