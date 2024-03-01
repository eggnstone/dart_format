import 'package:dart_format/dart_format.dart';
import 'package:dart_format/src/Analyzer.dart';
import 'package:dart_format/src/Tools/StringTools.dart';
import 'package:eggnstone_dart/eggnstone_dart.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    test('TODO Block comments: preserve indentation', ()
        {
            const String inputText = 'void f()\n'
            '{ /*START\n'
            '        TEXT\n'
            '            END*/\n'
            '    s;\n'
            '}\n';

            Analyzer().analyze(inputText);

            const Config config = Config.all();
            final Formatter formatter = Formatter(config);

            final String actualText = formatter.format(inputText);

            TestTools.expect(actualText, equals(inputText));

            logDebug('actualText:\n${StringTools.toDisplayString(actualText)}\n$actualText');
        }
    );
}
