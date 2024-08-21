import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../../../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config configNone = Config.none(indentationSpacesPerLevel: 4);
    final Formatter formatterNone = Formatter(configNone);

    group('ConstructorDeclarations (Indentations)', ()
        {
            test('Empty const constructor', ()
                {
                    const String inputText =  'class C\n{\nconst C();\n}';
                    const String expectedText =   'class C\n{\n    const C();\n}';

                    final String actualText = formatterNone.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
