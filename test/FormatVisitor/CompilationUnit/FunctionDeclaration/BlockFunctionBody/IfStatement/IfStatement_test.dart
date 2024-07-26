import 'package:dart_format/dart_format.dart';
import 'package:test/test.dart';

import '../../../../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config config = Config.none();
    final Formatter formatter = Formatter(config);

    group('IfStatements', ()
        {
            test('Simple if statement', ()
                {
                    const String inputText = 'void f(){if(true);}';
                    const String expectedText = 'void f(){if(true);}';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Simple if-else statement', ()
                {
                    const String inputText = 'void f(){if(true);else;}';
                    const String expectedText = 'void f(){if(true);else;}';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
