import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Formatter formatter = Formatter(Config.all());

    test('Record literal as the last argument collapses one indent level when ( and ) align with the outer call', ()
        {
            const String inputText =
                'void f()\n'
                '{\n'
                '    unawaited(compute(runner, (\n'
                '        cachePath: A,\n'
                '        docsPath: B\n'
                '    )));\n'
                '}\n';

            TestTools.expect(formatter.format(inputText), equals(inputText));
        }
    );

    test('Plain list literal as the last argument also collapses', ()
        {
            const String inputText =
                'void f()\n'
                '{\n'
                '    g(<int>[\n'
                '        1,\n'
                '        2\n'
                '    ]);\n'
                '}\n';

            TestTools.expect(formatter.format(inputText), equals(inputText));
        }
    );
}
