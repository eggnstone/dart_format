import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('FunctionDeclarations (Simple)', ()
        {
            test('Empty function with space before opening brace', ()
                {
                    final Config config = Config.none(addNewLineBeforeOpeningBrace: true);
                    final Formatter formatter = Formatter(config);

                    const String inputText = 'void f() {}';
                    const String expectedText = 'void f()\n{}';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
