import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:dart_format/src/LeadingWhitespaceRemover.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config configAll = Config.all();
    final Formatter formatterAll = Formatter(configAll);

    group('Playground 6', ()
        {
            test("format: Text in 3x'", ()
                {
                    const String inputText =
                    'void f()\n'
                    '{\n'
                    '    a(()\n'
                    '    {\n'
                    '        /*\n'
                    '         */\n'
                    '    });\n'
                    '}\n';
                    const String expectedText = inputText;

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
