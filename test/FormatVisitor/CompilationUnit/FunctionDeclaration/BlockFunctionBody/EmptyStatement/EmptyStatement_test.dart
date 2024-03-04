import 'package:dart_format/dart_format.dart';
import 'package:test/test.dart';

import '../../../../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config config = Config.none();
    final Formatter formatter = Formatter(config);

    group('EmptyStatements', ()
        {
            test('Empty for statement', ()
                {
                    const String inputText = 'void f(){;}';
                    const String expectedText = 'void f(){;}';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
