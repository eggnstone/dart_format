import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:dart_format/src/Tools/StringTools.dart';
import 'package:eggnstone_dart/eggnstone_dart.dart';
import 'package:test/test.dart';

import '../../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('FunctionDeclarations (Simple)', ()
        {
            test('Empty function with space before opening brace', ()
                {
                    final Config configNone = Config.none(addNewLineBeforeOpeningBrace: true);
                    final Formatter formatterNone = Formatter(configNone);

                    const String inputText = 'void f() {}';
                    const String expectedText = 'void f()\n{}';

                    final String actualText = formatterNone.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('void f(){return C();} (prevent connection of "return" and "C")', ()
                {
                    final Config configExperimental = Config.experimental();
                    final Formatter formatterExperimental = Formatter(configExperimental);

                    const String inputText = 'void f(){return C();}';
                    const String expectedText = 'void f()\n{\n    return C();\n}\n';

                    final String actualText = formatterExperimental.format(inputText);
                    logDebug('actualText: ${StringTools.toDisplayString(actualText)}');

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('void f(){if (true)  g();} (do not changes spaces between "if" and opening parenthesis)', ()
                {
                    final Config configAll = Config.all();
                    final Formatter formatterAll = Formatter(configAll);

                    const String inputText = 'void f(){if (true)  g();}';
                    const String expectedText = 'void f()\n{\n    if (true)  g();\n}\n';

                    final String actualText = formatterAll.format(inputText);
                    logDebug('actualText: ${StringTools.toDisplayString(actualText)}');

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('void f(){if (true)  g();} (keep one space between "if" and opening parenthesis)', ()
                {
                    final Config configExperimental = Config.experimental();
                    final Formatter formatterExperimental = Formatter(configExperimental);

                    const String inputText = 'void f(){if (true)  g();}';
                    const String expectedText = 'void f()\n{\n    if (true) g();\n}\n';

                    final String actualText = formatterExperimental.format(inputText);
                    logDebug('actualText: ${StringTools.toDisplayString(actualText)}');

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('void f(){File f;f=  File();}', ()
                {
                    final Config configExperimental = Config.experimental();
                    final Formatter formatterExperimental = Formatter(configExperimental);

                    const String inputText = 'void f(){File f;f=  File();}';
                    const String expectedText = 'void f()\n{\n    File f;\n    f = File();\n}\n';

                    final String actualText = formatterExperimental.format(inputText);
                    logDebug('actualText: ${StringTools.toDisplayString(actualText)}');

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('void f(){C c;c=  C.c();}', ()
                {
                    final Config configExperimental = Config.experimental();
                    final Formatter formatterExperimental = Formatter(configExperimental);

                    const String inputText = 'void f(){C c;c=  C.c();}';
                    const String expectedText = 'void f()\n{\n    C c;\n    c = C.c();\n}\n';

                    final String actualText = formatterExperimental.format(inputText);
                    logDebug('actualText: ${StringTools.toDisplayString(actualText)}');

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
