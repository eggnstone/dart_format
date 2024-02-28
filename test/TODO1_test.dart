import 'package:dart_format/dart_format.dart';
import 'package:dart_format/src/Analyzer.dart';
import 'package:dart_format/src/Tools/StringTools.dart';
import 'package:eggnstone_dart/eggnstone_dart.dart';
import 'package:test/test.dart';

import 'TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    test('TODO1', ()
        {
            const String inputText =
            'void f()\n'
            '{\n'
            '    var l = [\n'
            '        C(\n'
            '        ),\n'
            '        /*D(\n'
            '        ),*/\n'
            '    ];\n'
            '}\n';

            // TODO: fix
            const String expectedText =
            'void f()\n'
            '{\n'
            '    var l = [\n'
            '        C(\n'
            '        )\n'
            '    /*D(\n' // Fix this line
            '    ),*/\n' // Fix this line
            '    ];\n'
            '}\n';

            Analyzer().analyze(inputText);

            const Config config = Config.all();
            final Formatter formatter = Formatter(config);

            // Expect to not throw.
            final String actualText = formatter.format(inputText);

            TestTools.expect(actualText, equals(expectedText));

            logDebug('actualText:\n${StringTools.toDisplayString(actualText)}\n$actualText');
        }
    );
}
