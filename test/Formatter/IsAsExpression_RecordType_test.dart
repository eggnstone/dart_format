import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config configAll = Config.all();
    final Formatter formatterAll = Formatter(configAll);

    test('"is!" before a record type keeps the space', ()
        {
            const String inputText =
                'void f(){\n'
                'if (m is!({String A, String B}))\n'
                ';\n'
                '}\n';
            const String expectedText =
                'void f()\n'
                '{\n'
                '    if (m is! ({String A, String B}))\n'
                '        ;\n'
                '}\n';

            final String actualText = formatterAll.format(inputText);

            TestTools.expect(actualText, equals(expectedText));
        }
    );

    test('"is" before a record type keeps the space', ()
        {
            const String inputText =
                'void f(){\n'
                'if (m is({String A, String B}))\n'
                ';\n'
                '}\n';
            const String expectedText =
                'void f()\n'
                '{\n'
                '    if (m is ({String A, String B}))\n'
                '        ;\n'
                '}\n';

            final String actualText = formatterAll.format(inputText);

            TestTools.expect(actualText, equals(expectedText));
        }
    );

    test('"as" before a record type keeps the space', ()
        {
            const String inputText =
                'void f(){\n'
                'final x = y as(int, int);\n'
                '}\n';
            const String expectedText =
                'void f()\n'
                '{\n'
                '    final x = y as (int, int);\n'
                '}\n';

            final String actualText = formatterAll.format(inputText);

            TestTools.expect(actualText, equals(expectedText));
        }
    );

    test('"is" before a simple type still works', ()
        {
            const String inputText =
                'void f(){\n'
                'if (m is T)\n'
                ';\n'
                '}\n';
            const String expectedText =
                'void f()\n'
                '{\n'
                '    if (m is T)\n'
                '        ;\n'
                '}\n';

            final String actualText = formatterAll.format(inputText);

            TestTools.expect(actualText, equals(expectedText));
        }
    );

    test('"is!" before a simple type still works', ()
        {
            const String inputText =
                'void f(){\n'
                'if (m is! T)\n'
                ';\n'
                '}\n';
            const String expectedText =
                'void f()\n'
                '{\n'
                '    if (m is! T)\n'
                '        ;\n'
                '}\n';

            final String actualText = formatterAll.format(inputText);

            TestTools.expect(actualText, equals(expectedText));
        }
    );

    test('"as" before a simple type still works', ()
        {
            const String inputText =
                'void f(){\n'
                'final x = y as T;\n'
                '}\n';
            const String expectedText =
                'void f()\n'
                '{\n'
                '    final x = y as T;\n'
                '}\n';

            final String actualText = formatterAll.format(inputText);

            TestTools.expect(actualText, equals(expectedText));
        }
    );
}
