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
            test('format: MethodDeclaration', ()
                {
                    const String inputText = 'class  C  {  @a  void  c  (  )  {  }  }';
                    const String expectedText =
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

            test('format: VariableDeclarationListFormatter', ()
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
        }
    );
}
