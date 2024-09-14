import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config config = Config.experimental();
    final Formatter formatter = Formatter(config);

    group('Playground 9', ()
        {
            test('format: void f() { g(i: 0); }', ()
                {
                    const String inputText = 'void  f  (  )  {  g  (  i  :  0  )  ;  }  ';
                    const String expectedText =
                        'void f()\n'
                        '{\n'
                        '    g(i: 0);\n'
                        '}  \n';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
