import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('MethodInvocation and ArgumentList', ()
        {
            test(r'1 a(()\n{\n}\n)', ()
                {
                    const String inputText = 'void f()\n{\n    a(()\n        {\n        }\n    );\n}\n';
                    const String expectedText = inputText;

                    final Config config = Config.all();
                    final Formatter formatter = Formatter(config);
                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test(r'2 a(\n()\n{\n}\n)', ()
                {
                    const String inputText = 'void f()\n{\n    a(\n        ()\n        {\n        }\n    );\n}\n';
                    const String expectedText = inputText;

                    final Config config = Config.all();
                    final Formatter formatter = Formatter(config);
                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test(r'3 a.b(()\n{\n}\n)', ()
                {
                    const String inputText = 'void f()\n{\n    a.b(()\n        {\n        }\n    );\n}\n';
                    const String expectedText = inputText;

                    final Config config = Config.all();
                    final Formatter formatter = Formatter(config);
                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test(r'4 a\n.b(()\n{\n}\n)', ()
                {
                    const String inputText = 'void f()\n{\n    a\n        .b(()\n            {\n            }\n        );\n}\n';
                    const String expectedText = inputText;

                    final Config config = Config.all();
                    final Formatter formatter = Formatter(config);
                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test(r'5 a\n.b(\n()\n{\n}\n)', ()
                {
                    const String inputText = 'void f()\n{\n    a\n        .b(\n            ()\n            {\n            }\n        );\n}\n';
                    const String expectedText = inputText;

                    final Config config = Config.all();
                    final Formatter formatter = Formatter(config);
                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
