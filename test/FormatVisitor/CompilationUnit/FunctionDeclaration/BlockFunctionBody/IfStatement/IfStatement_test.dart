import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../../../../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config configNone = Config.none();
    final Formatter formatterNone = Formatter(configNone);

    group('IfStatements', ()
        {
            test('Simple if statement', ()
                {
                    const String inputText = 'void f(){if(true);}';
                    const String expectedText = 'void f(){if(true);}';

                    final String actualText = formatterNone.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Simple if-else statement', ()
                {
                    const String inputText = 'void f(){if(true);else;}';
                    const String expectedText = 'void f(){if(true);else;}';

                    final String actualText = formatterNone.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
