import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config configAll = Config.all();
    final Formatter formatterAll = Formatter(configAll);

    group('Playground 1', ()
        {
            test(r"String s = '/*';\n", ()
                {
                    const String inputText = "String s = '/*';\n";
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test(r"String s =\n    'a';\n", ()
                {
                    const String inputText =
                        'String s =\n'
                        "    'a';\n";
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test(r"String s =\n    'a'\n    'b';\n", ()
                {
                    const String inputText =
                        'String s =\n'
                        "    'a'\n"
                        "    'b';\n";
                    const String expectedText = inputText;

                    //Analyzer.analyze(inputText);
                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test(r"String s = 'a'\n    'b';\n", ()
                {
                    const String inputText =
                        "String s = 'a'\n"
                        "    'b';\n";
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
