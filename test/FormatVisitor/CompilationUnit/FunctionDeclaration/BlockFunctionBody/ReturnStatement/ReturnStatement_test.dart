import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../../../../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config configNone = Config.none();
    final Formatter formatterNone = Formatter(configNone);

    group('ReturnStatements', ()
        {
            test('Simple return statement', ()
                {
                    const String inputText = 'void f(){return;}';
                    const String expectedText = 'void f(){return;}';

                    final String actualText = formatterNone.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
