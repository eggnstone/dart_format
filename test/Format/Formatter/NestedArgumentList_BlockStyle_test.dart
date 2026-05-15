import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Format/Formatter.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config configAll = Config.all();
    final Formatter formatterAll = Formatter(configAll);

    test('Nested call with parens aligned on open/close lines collapses one indent level', ()
        {
            const String inputText =
                'void f(){\n'
                'g(m(\n'
                'A,\n'
                'B\n'
                '));\n'
                '}\n';
            const String expectedText =
                'void f()\n'
                '{\n'
                '    g(m(\n'
                '        A,\n'
                '        B\n'
                '    ));\n'
                '}\n';

            final String actualText = formatterAll.format(inputText);

            TestTools.expect(actualText, equals(expectedText));
        }
    );

    test('Nested call with inner closing on its own line keeps both indent levels', ()
        {
            const String inputText =
                'void f(){\n'
                'g(m(\n'
                'A\n'
                ')\n'
                ');\n'
                '}\n';
            const String expectedText =
                'void f()\n'
                '{\n'
                '    g(m(\n'
                '            A\n'
                '        )\n'
                '    );\n'
                '}\n';

            final String actualText = formatterAll.format(inputText);

            TestTools.expect(actualText, equals(expectedText));
        }
    );

    test('Nested call on a single line stays unchanged', ()
        {
            const String inputText =
                'void f(){\n'
                'g(m(A));\n'
                '}\n';
            const String expectedText =
                'void f()\n'
                '{\n'
                '    g(m(A));\n'
                '}\n';

            final String actualText = formatterAll.format(inputText);

            TestTools.expect(actualText, equals(expectedText));
        }
    );

    test('Outer with leading args still collapses when last arg is inline-block', ()
        {
            const String inputText =
                'void f(){\n'
                'g(A, m(\n'
                'B\n'
                '));\n'
                '}\n';
            const String expectedText =
                'void f()\n'
                '{\n'
                '    g(A, m(\n'
                '        B\n'
                '    ));\n'
                '}\n';

            final String actualText = formatterAll.format(inputText);

            TestTools.expect(actualText, equals(expectedText));
        }
    );

    test('Three nested calls fully aligned collapse to one indent level', ()
        {
            const String inputText =
                'void f(){\n'
                'g(m(n(\n'
                'A,\n'
                'B\n'
                ')));\n'
                '}\n';
            const String expectedText =
                'void f()\n'
                '{\n'
                '    g(m(n(\n'
                '        A,\n'
                '        B\n'
                '    )));\n'
                '}\n';

            final String actualText = formatterAll.format(inputText);

            TestTools.expect(actualText, equals(expectedText));
        }
    );

    test('Three nested calls with only innermost closing split keep two indent levels', ()
        {
            const String inputText =
                'void f(){\n'
                'g(m(n(\n'
                'A,\n'
                'B\n'
                ')\n'
                '));\n'
                '}\n';
            const String expectedText =
                'void f()\n'
                '{\n'
                '    g(m(n(\n'
                '            A,\n'
                '            B\n'
                '        )\n'
                '    ));\n'
                '}\n';

            final String actualText = formatterAll.format(inputText);

            TestTools.expect(actualText, equals(expectedText));
        }
    );

    test('Three nested calls with every closing on its own line keep three indent levels', ()
        {
            const String inputText =
                'void f(){\n'
                'g(m(n(\n'
                'A\n'
                ')\n'
                ')\n'
                ');\n'
                '}\n';
            const String expectedText =
                'void f()\n'
                '{\n'
                '    g(m(n(\n'
                '                A\n'
                '            )\n'
                '        )\n'
                '    );\n'
                '}\n';

            final String actualText = formatterAll.format(inputText);

            TestTools.expect(actualText, equals(expectedText));
        }
    );

    test('Three nested calls with leading args at each level collapse to one indent level', ()
        {
            const String inputText =
                'void f(){\n'
                'g(A, m(B, n(\n'
                'C\n'
                ')));\n'
                '}\n';
            const String expectedText =
                'void f()\n'
                '{\n'
                '    g(A, m(B, n(\n'
                '        C\n'
                '    )));\n'
                '}\n';

            final String actualText = formatterAll.format(inputText);

            TestTools.expect(actualText, equals(expectedText));
        }
    );

    test('Three nested calls with leading args and only innermost closing split keep two indent levels', ()
        {
            const String inputText =
                'void f(){\n'
                'g(A, m(B, n(\n'
                'C\n'
                ')\n'
                '));\n'
                '}\n';
            const String expectedText =
                'void f()\n'
                '{\n'
                '    g(A, m(B, n(\n'
                '            C\n'
                '        )\n'
                '    ));\n'
                '}\n';

            final String actualText = formatterAll.format(inputText);

            TestTools.expect(actualText, equals(expectedText));
        }
    );

    test('Three nested calls with leading args and every closing on its own line keep three indent levels', ()
        {
            const String inputText =
                'void f(){\n'
                'g(A, m(B, n(\n'
                'C\n'
                ')\n'
                ')\n'
                ');\n'
                '}\n';
            const String expectedText =
                'void f()\n'
                '{\n'
                '    g(A, m(B, n(\n'
                '                C\n'
                '            )\n'
                '        )\n'
                '    );\n'
                '}\n';

            final String actualText = formatterAll.format(inputText);

            TestTools.expect(actualText, equals(expectedText));
        }
    );

    test('Two stacked block-pattern pairs at different depths each collapse independently', ()
        {
            const String inputText =
                'void f(){\n'
                'a(b(\n'
                'c(d(\n'
                '))\n'
                '));\n'
                '}\n';
            const String expectedText =
                'void f()\n'
                '{\n'
                '    a(b(\n'
                '        c(d(\n'
                '        ))\n'
                '    ));\n'
                '}\n';

            final String actualText = formatterAll.format(inputText);

            TestTools.expect(actualText, equals(expectedText));
        }
    );

    test('Two stacked block-pattern pairs with content at the innermost', ()
        {
            const String inputText =
                'void f(){\n'
                'a(b(\n'
                'c(d(\n'
                'A\n'
                '))\n'
                '));\n'
                '}\n';
            const String expectedText =
                'void f()\n'
                '{\n'
                '    a(b(\n'
                '        c(d(\n'
                '            A\n'
                '        ))\n'
                '    ));\n'
                '}\n';

            final String actualText = formatterAll.format(inputText);

            TestTools.expect(actualText, equals(expectedText));
        }
    );

    test('Two stacked block-pattern pairs with leading args at each level', ()
        {
            const String inputText =
                'void f(){\n'
                'a(X, b(\n'
                'Y, c(d(\n'
                'A\n'
                '))\n'
                '));\n'
                '}\n';
            const String expectedText =
                'void f()\n'
                '{\n'
                '    a(X, b(\n'
                '        Y, c(d(\n'
                '            A\n'
                '        ))\n'
                '    ));\n'
                '}\n';

            final String actualText = formatterAll.format(inputText);

            TestTools.expect(actualText, equals(expectedText));
        }
    );
}
