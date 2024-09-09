import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config configAll = Config.all();
    final Formatter formatterAll = Formatter(configAll);

    group('Playground 12', ()
        {
            test('format: void f() { g(T<String>.t()); }', ()
                {
                    const String inputText = 'void f() { g(T<String>.t()); }';
                    const String expectedText =
                        'void f()\n'
                        '{\n'
                        '    g(T<String>.t());\n'
                        '}\n';

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
