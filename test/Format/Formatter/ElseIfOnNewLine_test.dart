import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Format/Formatter.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Formatter formatter = Formatter(Config.all());

    test('else followed by if on a new line indents the inner if one level past else', ()
        {
            const String inputText =
                'void f()\n'
                '{\n'
                '    if (true)\n'
                '        ;\n'
                '    else\n'
                '    if (true)\n'
                '        ;\n'
                '}\n';
            const String expectedText =
                'void f()\n'
                '{\n'
                '    if (true)\n'
                '        ;\n'
                '    else\n'
                '        if (true)\n'
                '            ;\n'
                '}\n';

            TestTools.expect(formatter.format(inputText), equals(expectedText));
        }
    );

    test('canonical "else if" on a single line stays unchanged (no extra indent)', ()
        {
            const String inputText =
                'void f()\n'
                '{\n'
                '    if (true)\n'
                '        ;\n'
                '    else if (true)\n'
                '        ;\n'
                '}\n';

            TestTools.expect(formatter.format(inputText), equals(inputText));
        }
    );
}
