import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config configAll = Config.all();
    final Formatter formatterAll = Formatter(configAll);

    group('Playground 9', ()
        {
            test("format: 'void f(){}'", ()
                {
                    const String inputText = 'void  f  (  )  {  g  (  i  :  0  )  ;  }  ';
                    const String expectedText =
                        'void f()\n'
                        '{\n'
                        '    g(  i:  0)  ;\n'
                        '}\n';

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
