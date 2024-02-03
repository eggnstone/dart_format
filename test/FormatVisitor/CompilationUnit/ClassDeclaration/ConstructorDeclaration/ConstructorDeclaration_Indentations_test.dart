import 'package:dart_format/dart_format.dart';
import 'package:test/test.dart';

import '../../../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    const Config config = Config.none(indentationSpacesPerLevel: 4);
    final Formatter formatter = Formatter(config);

    group('ConstructorDeclarations (Indentations)', ()
        {
            test('Empty const constructor', ()
                {
                    const String inputText =  'class C\n{\nconst C();\n}';
                    const String expectedText =   'class C\n{\n    const C();\n}';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
