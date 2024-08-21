import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config configAll = Config.all();
    final Formatter formatterAll = Formatter(configAll);

    group('Playground 3', ()
        {
            test(r"void f(){g('$a');}", ()
                {
                    const String inputText = r"void f(){g('$a');}";
                    const String expectedText = "void f()\n{\n    g('\$a');\n}\n";

                    //Analyzer.analyze(inputText);

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test(r"void f(){g('a$b');}", ()
                {
                    const String inputText = r"void f(){g('a$b');}";
                    const String expectedText = "void f()\n{\n    g('a\$b');\n}\n";

                    //Analyzer.analyze(inputText);

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test(r'/**//**/\n', ()
                {
                    const String inputText = '/**//**/\n';
                    const String expectedText = inputText;

                    //Analyzer.analyze(inputText);

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test(r"String s = r'\';\n", ()
                {
                    const String inputText = "String s = r'\\';\n";
                    const String expectedText = inputText;

                    //Analyzer.analyze(inputText);

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );
        }
    );
}
