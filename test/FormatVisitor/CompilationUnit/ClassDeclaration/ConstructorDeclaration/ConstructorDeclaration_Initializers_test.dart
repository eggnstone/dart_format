import 'package:dart_format/dart_format.dart';
import 'package:test/test.dart';

import '../../../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    const Config config = Config.none();
    final Formatter formatter = Formatter(config);

    group('ConstructorDeclarations (Initializers)', ()
        {
            test('Constructor with "super" initializer', ()
                {
                    const String inputText = 'class C{const C():super();}';
                    const String expectedText = inputText;

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Constructor with 2 field initializers, without space', ()
                {
                    const String inputText = 'class C{const C():a=0,b=0;}';
                    const String expectedText = inputText;

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Constructor with 2 field initializers, with space', ()
                {
                    const String inputText = 'class C{const C():a=0, b=0;}';
                    const String expectedText = inputText;

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Constructor with "this" field initializers', ()
                {
                    const String inputText = 'class C{C():this.a=0;}';
                    const String expectedText = inputText;

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
