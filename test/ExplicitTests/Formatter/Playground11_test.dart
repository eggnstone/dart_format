import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config config = Config.experimental();
    final Formatter formatter = Formatter(config);

    group('Playground 11', ()
        {
            test('format: class C extends E', ()
                {
                    const String inputText = 'class  C  extends  E  {'
                        '  C  (  {  super  .  key  }  )  ;'
                        '  C  (  {  required  super  .  key  }  )  ;'
                        '  const  C  (  {  super  .  key  }  )  ;'
                        '  }  ';
                    const String expectedText =
                        'class C extends E\n'
                        '{\n'
                        '    C({super.key});\n'
                        '    C({required super.key});\n'
                        '    const C({super.key});\n'
                        '}  \n';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
