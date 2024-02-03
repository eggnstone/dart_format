import 'package:dart_format/dart_format.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    const Config config = Config.all();
    final Formatter formatter = Formatter(config);

    group('Formatter.format: indentation', ()
        {
            test('Function / ExpressionStatement', ()
                {
                    const String inputText = 'void f(){a;}';
                    const String expectedText = 'void f()\n{\n    a;\n}\n';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Function / IfStatement / EmptyStatement', ()
                {
                    const String inputText = 'void f(){if(true)\n;}';
                    const String expectedText = 'void f()\n{\n    if(true)\n        ;\n}\n';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Function / IfStatement / ExpressionStatement', ()
                {
                    const String inputText = 'void f(){if(true)\na;}';
                    const String expectedText = 'void f()\n{\n    if(true)\n        a;\n}\n';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Function / IfStatement / empty Block', ()
                {
                    const String inputText = 'void f(){if(true)\n{}}';
                    const String expectedText = 'void f()\n{\n    if(true)\n    {\n    }\n}\n';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Function / IfStatement / Block / ExpressionStatement', ()
                {
                    const String inputText = 'void f(){if(true)\n{a;}}';
                    const String expectedText = 'void f()\n{\n    if(true)\n    {\n        a;\n    }\n}\n';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Function / empty anonymous function as method param', ()
                {
                    const String inputText = 'void f(){a((){});}';
                    //const String expectedText = 'void f()\n{\n    a((){});\n}\n';
                    const String expectedText = 'void f()\n{\n    a(()\n        {\n        }\n    );\n}\n';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Function / non-empty anonymous function as method param', ()
                {
                    const String inputText = 'void f(){a((){b;});}';
                    //const String expectedText = 'void f()\n{\n    a((){b;});\n}\n';
                    const String expectedText = 'void f()\n{\n    a(()\n        {\n            b;\n        }\n    );\n}\n';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Function / non-empty anonymous function as method param / line breaks', ()
                {
                    const String inputText = 'void f(){a((){\nb;\n});}';
                    //const String expectedText = 'void f()\n{\n    a((){\n        b;\n    });\n}\n';
                    const String expectedText = 'void f()\n{\n    a(()\n        {\n            b;\n        }\n    );\n}\n';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
