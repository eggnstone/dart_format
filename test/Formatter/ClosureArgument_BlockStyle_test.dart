import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Formatter formatterInline = Formatter(Config.all(
        addNewLineBeforeOpeningBrace: false,
        addNewLineAfterClosingBrace: false
    ));

    test('Call with closure arg whose { and } sit on the outer paren lines collapses one indent level', ()
        {
            const String inputText =
                'void f(){\n'
                'g(() {\n'
                'A;\n'
                '});\n'
                '}\n';
            const String expectedText =
                'void f() {\n'
                '    g(() {\n'
                '        A;\n'
                '    });\n'
                '}\n';

            final String actualText = formatterInline.format(inputText);

            TestTools.expect(actualText, equals(expectedText));
        }
    );

    test('Empty closure body keeps the call at the outer indent (and its inner blank line is stripped by the brace-adjacent rule)', ()
        {
            const String inputText =
                'void f(){\n'
                'g(() {\n'
                '\n'
                '});\n'
                '}\n';
            const String expectedText =
                'void f() {\n'
                '    g(() {\n'
                '    });\n'
                '}\n';

            final String actualText = formatterInline.format(inputText);

            TestTools.expect(actualText, equals(expectedText));
        }
    );
}
