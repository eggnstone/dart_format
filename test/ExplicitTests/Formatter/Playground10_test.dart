import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config configAll = Config.all();
    final Formatter formatterAll = Formatter(configAll);

    group('Playground 10', ()
        {
            test("format: 'runApp(const MyApp());'", ()
                {
                    const String inputText = 'void f  (  )  {  runApp  (  MyApp  (  )  )  ;  runApp  (  const  MyApp  (  )  )  ;  }  ';
                    const String expectedText =
                        'void f()\n'
                        '{\n'
                        '    runApp(MyApp())  ;\n'
                        '    runApp(const MyApp())  ;\n'
                        '}  \n';

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}