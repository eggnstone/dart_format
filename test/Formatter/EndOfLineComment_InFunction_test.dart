import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config configAll = Config.all();
    final Formatter formatterAll = Formatter(configAll);

    group('EndOfLine comments in function', ()
        {
            test('Normal', ()
                {
                    const String inputText = 
                        'void f()\n'
                        '{\n'
                        '    a;\n'
                        '    // EOL\n'
                        '}\n';
                    const String expectedText = inputText;



                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

        }
    );
}
