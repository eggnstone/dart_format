import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config config = Config.none();
    final Formatter formatter = Formatter(config);

    group('TopLevelVariableDeclaration', ()
        {
            test('Simple', ()
                {
                    const String inputText = 'int i = 0;\n';
                    const String expectedText = inputText;

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
