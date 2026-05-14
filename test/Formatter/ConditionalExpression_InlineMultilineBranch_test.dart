import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Formatter formatter = Formatter(Config.all(removeTrailingCommas: false));

    test('ConditionalExpression whose else-branch is a multi-line list literal does not double-indent the closing ]', ()
        {
            const String inputText =
                'void f()\n'
                '{\n'
                '    return Scaffold(\n'
                '        appBar: AppBar(\n'
                '            actions: cond ? null : <Widget>[\n'
                '                ],\n'
                '        )\n'
                '    );\n'
                '}\n';
            const String expectedText =
                'void f()\n'
                '{\n'
                '    return Scaffold(\n'
                '        appBar: AppBar(\n'
                '            actions: cond ? null : <Widget>[\n'
                '            ],\n'
                '        )\n'
                '    );\n'
                '}\n';

            TestTools.expect(formatter.format(inputText), equals(expectedText));
        }
    );
}
