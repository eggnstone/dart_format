import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config config = Config.experimental();
    final Formatter formatter = Formatter(config);

    group('Playground 8', ()
        {
            test('format: if', ()
                {
                    const String inputText = 'void f(){if  /**/  (  /**/  true  /**/  )  /**/  ;                  /**/  else  /**/  ;}';
                    const String expectedText =
                        'void f()\n'
                        '{\n'
                        '    if /**/ (  /**/  true /**/)  /**/  ;\n'
                        '    /**/ else  /**/  ;\n'
                        '}\n';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
