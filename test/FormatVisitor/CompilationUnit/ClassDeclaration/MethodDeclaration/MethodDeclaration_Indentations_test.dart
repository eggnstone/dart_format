import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../../../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config config = Config.none(indentationSpacesPerLevel: 4);
    final Formatter formatter = Formatter(config);

    group('MethodDeclarations (Indentations)', ()
        {
            test('Simple method', ()
                {
                    const String inputText =  'class C\n{\nvoid m()\n{\n}\n}';
                    const String expectedText =   'class C\n{\n    void m()\n    {\n    }\n}';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
