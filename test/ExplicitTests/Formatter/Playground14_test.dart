import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config config = Config.experimental();
    final Formatter formatter = Formatter(config);

    group('Playground 14', ()
        {
            test('format: void f() { for(int i=0;i<10;i++); }', ()
                {
                    const String inputText = 'void f() { for(int i=0;i<10;i++); }';
                    const String expectedText =
                        'void f()\n'
                        '{\n'
                        '    for (int i = 0; i < 10; i++);\n'
                        '}\n';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
