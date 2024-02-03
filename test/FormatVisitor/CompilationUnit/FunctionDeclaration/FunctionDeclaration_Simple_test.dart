import 'package:dart_format/dart_format.dart';
import 'package:test/test.dart';

import '../../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('FunctionDeclarations (Simple)', ()
        {
            test('Empty function with space before opening brace', ()
                {
                    const Config config = Config.none(addNewLineBeforeOpeningBrace: true);
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
