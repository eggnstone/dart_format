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

            test('format: MethodDeclaration / D<C> c()', ()
                {
                    const String inputText = 'class C{D< C > c() => d();}';
                    const String expectedText = 'class C\n{\n    D<C> c() => d();\n}\n';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('format: MethodDeclaration / D<C> c()', ()
                {
                    const String inputText = 'void f(bool? b){}';
                    const String expectedText = 'void f(bool? b)\n{\n}\n';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('format: MethodDeclaration / D<C> c()', ()
                {
                    const String inputText = 'final A.B r = x();';
                    const String expectedText = 'final A.B r = x();\n';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('format: TODO 1', ()
                {
                    const String inputText = 'typedef IntTuple = Tuple<int, int>;\n';
                    const String expectedText = inputText;

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('format: TODO 2', ()
                {
                    const String inputText = 'void f()\n{\n    if (a is B);\n}\n';
                    const String expectedText = inputText;

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('format: TODO 3', ()
                {
                    const String inputText = 'void f()\n{\n    if (a is! B);\n}\n';
                    const String expectedText = inputText;

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('format: TODO 4', ()
                {
                    const String inputText = 'var  x  =  <  A  ,  B  >  [  a  ,  b  ]  ;';
                    const String expectedText = 'var x = <A, B>[a, b];\n';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('format: TODO 5', ()
                {
                    const String inputText = 'var  x  =  y  ++  ;';
                    const String expectedText = 'var x = y++;\n';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('format: TODO 6', ()
                {
                    const String inputText = 'void  f  (  )  {  for  (  int  i  =  0  ;  i  >=  0  ;  i  --  )  ;}';
                    const String expectedText = 'void f()\n{\n    for (int i = 0; i >= 0; i--);\n}\n';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('format: TODO 7', ()
                {
                    const String inputText = 'class C{C(A this.a){}}\n';
                    const String expectedText = 'class C\n{\n    C(A this.a)\n    {\n    }\n}\n';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
