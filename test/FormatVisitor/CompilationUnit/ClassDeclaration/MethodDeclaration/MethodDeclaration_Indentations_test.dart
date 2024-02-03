import 'package:dart_format/dart_format.dart';
import 'package:test/test.dart';

import '../../../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    const Config config = Config.none(indentationSpacesPerLevel: 4);
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
