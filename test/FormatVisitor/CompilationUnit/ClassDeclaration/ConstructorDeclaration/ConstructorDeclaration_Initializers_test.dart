import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../../../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config configNone = Config.none();
    final Formatter formatterNone = Formatter(configNone);

    group('ConstructorDeclarations (Initializers)', ()
        {
            test('Constructor with "super" initializer', ()
                {
                    const String inputText = 'class C{const C():super();}';
                    const String expectedText = inputText;

                    final String actualText = formatterNone.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Constructor with 2 field initializers, without space', ()
                {
                    const String inputText = 'class C{const C():a=0,b=0;}';
                    const String expectedText = inputText;

                    final String actualText = formatterNone.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Constructor with 2 field initializers, with space', ()
                {
                    const String inputText = 'class C{const C():a=0, b=0;}';
                    const String expectedText = inputText;

                    final String actualText = formatterNone.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Constructor with "this" field initializers', ()
                {
                    const String inputText = 'class C{C():this.a=0;}';
                    const String expectedText = inputText;

                    final String actualText = formatterNone.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
