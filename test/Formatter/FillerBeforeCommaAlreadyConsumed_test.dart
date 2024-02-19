import 'package:dart_format/dart_format.dart';
import 'package:dart_format/src/Analyzer.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

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
            '        }\n'
            '        , (__)\n'
            '        {\n'
            '        }\n'
            '    );\n'
            '}\n';

            Analyzer().analyze(inputText);

            const Config config = Config.all();
            final Formatter formatter = Formatter(config);
            final String actualText = formatter.format(inputText);

            TestTools.expect(actualText, equals(expectedText));
        }
    );
}
