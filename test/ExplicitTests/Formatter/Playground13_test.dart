import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config configAll = Config.all();
    final Formatter formatterAll = Formatter(configAll);

    group('Playground 13', ()
        {
            test('format: void f() { g(T<String>.t()); }', ()
                {
                    const String inputText = 'void f() async { await Future<void>.delayed(); }';
                    const String expectedText =
                        'void f() async\n'
                        '{\n'
                        '    await Future<void>.delayed();\n'
                        '}\n';

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
