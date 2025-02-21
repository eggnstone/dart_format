import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config config = Config.experimental();
    final Formatter formatter = Formatter(config);

    group('Playground 17', ()
        {
            test('format: ClassDeclaration / class C {@a void c() {}}', ()
                {
                    const String inputText = 'class  C  {  @a  void  c  (  )  {  }  }';
                    const String expectedText =
                        // TODO: '@a void c() \n'
                        'class C\n'
                        '{\n'
                        '    @a void c() \n'
                        '    {\n'
                        '    }\n'
                        '}\n';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('format: ClassDeclaration / class C {final bool b;}', ()
                {
                    const String inputText = 'class  C  {  final  bool  b  ;  }';
                    const String expectedText =
                        'class C\n'
                        '{\n'
                        '    final bool b;\n'
                        '}\n';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('format: FunctionDeclaration / bool f() => false;', ()
                {
                    const String inputText = 'bool f() => false;\n';
                    const String expectedText = inputText;

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('format: ClassDeclaration / class C {void f();}', ()
                {
                    const String inputText = 'class C{void f();}';
                    const String expectedText = 'class C\n{\n    void f();\n}\n';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('format: FunctionDeclaration / void f()=>g();', ()
                {
                    const String inputText = 'void f()=>g();\n';
                    const String expectedText = 'void f() => g();\n';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('format: FunctionDeclaration / void  f  (  )  =>  g  (  )  ;', ()
                {
                    const String inputText = 'void  f  (  )  =>  g  (  )  ;\n';
                    const String expectedText = 'void f() => g();\n';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test(r'format: FunctionDeclaration / void f()\n=>g();', ()
                {
                    const String inputText = 'void f()\n=>g();\n';
                    const String expectedText = 'void f()\n=> g();\n';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
