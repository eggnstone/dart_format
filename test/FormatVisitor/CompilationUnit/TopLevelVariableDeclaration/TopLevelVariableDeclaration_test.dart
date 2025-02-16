import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config config = Config.experimental();
    final Formatter formatter = Formatter(config);

    group('TopLevelVariableDeclaration', ()
        {
            test('Simple', ()
                {
                    const String inputText = 'int  i  =  0  ;\n';
                    const String expectedText = 'int i = 0;\n';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('TODO', ()
                {
                    const String inputText = 'int  f  (  )  {  return  0;  }';
                    const String expectedText = 'int f()\n{\n    return 0;\n}\n';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
