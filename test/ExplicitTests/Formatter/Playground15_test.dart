import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config config = Config.experimental();
    final Formatter formatter = Formatter(config);

    group('Playground 15', ()
        {
            test('format: super', ()
                {
                    const String inputText = 'class C{ C(X super.c); }';
                    const String expectedText =
                        'class C\n'
                        '{\n'
                        '    C(X super.c);\n'
                        '}\n';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
