import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../../../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config config = Config.none();
    final Formatter formatter = Formatter(config);

    group('MethodDeclarations (Simple)', ()
        {
            test('Static method', ()
                {
                    const String inputText = 'class C{static void m(){}}';
                    const String expectedText = inputText;

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
