import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config configAll = Config.all();
    final Formatter formatterAll = Formatter(configAll);

    test('Filler before "," already consumed', ()
        {
            const String inputText = 
                'void f(void Function(int a) a, void Function(int b) b)\n'
                '{\n'
                'f((_) {} , (__) {});\n'
                '}';
            const String expectedText =
                'void f(void Function(int a) a, void Function(int b) b)\n'
                '{\n'
                '    f((_)\n'
                '        {\n'
                '        } , (__)\n'
                '        {\n'
                '        }\n'
                '    );\n'
                '}\n';

            final String actualText = formatterAll.format(inputText);

            TestTools.expect(actualText, equals(expectedText));
        }
    );
}
