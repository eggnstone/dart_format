import 'package:dart_format/dart_format.dart';
import 'package:test/test.dart';

import '../../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    const Config config = Config.none();
    final Formatter formatter = Formatter(config);

    group('ImportDirectives', ()
        {
            test('Simple import directive', ()
                {
                    const String inputText = "import 'a.dart';\n";
                    const String expectedText = inputText;

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
