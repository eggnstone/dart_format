import 'package:dart_format/dart_format.dart';
import 'package:dart_format/src/Analyzer.dart';
import 'package:dart_format/src/Tools/StringTools.dart';
import 'package:eggnstone_dart/eggnstone_dart.dart';
import 'package:test/test.dart';

import '../../test/TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    test('Playground 1', ()
        {
            const String inputText = "const String s =\n'a'\n'b';";
            const String expectedText = "const String s =\n    'a'\n    'b';\n";

            Analyzer().analyze(inputText);

            final Config config = Config.all();
            final Formatter formatter = Formatter(config);
            final String actualText = formatter.format(inputText);

            TestTools.expect(actualText, equals(expectedText));
            logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
        }
    );

    test('Playground 2', ()
        {
            const String inputText = "const String s = 'a'\n'b';";
            const String expectedText = "const String s = 'a'\n    'b';\n";

            Analyzer().analyze(inputText);

            final Config config = Config.all();
            final Formatter formatter = Formatter(config);
            final String actualText = formatter.format(inputText);

            TestTools.expect(actualText, equals(expectedText));
            logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
        }
    );
}
