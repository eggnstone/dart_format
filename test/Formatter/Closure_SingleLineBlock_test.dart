import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config configAll = Config.all();
    final Formatter formatterAll = Formatter(configAll);

    test('Closure argument with single-line block keeps single-line layout', ()
        {
            const String inputText = 'void f(){setState(()        {            _counter++;        }    );}';
            const String expectedText = 'void f()\n{\n    setState(() { _counter++; });\n}\n';

            final String actualText = formatterAll.format(inputText);

            TestTools.expect(actualText, equals(expectedText));
        }
    );

    test('Closure argument with multi-line block keeps multi-line layout', ()
        {
            const String inputText = 'void f(){setState(()\n{\n_counter++;\n}\n);}';
            const String expectedText = 'void f()\n{\n    setState(()\n        {\n            _counter++;\n        }\n    );\n}\n';

            final String actualText = formatterAll.format(inputText);

            TestTools.expect(actualText, equals(expectedText));
        }
    );

    test('Top-level function with single-line block still gets expanded', ()
        {
            const String inputText = 'void f() { x; }';
            const String expectedText = 'void f()\n{\n    x;\n}\n';

            final String actualText = formatterAll.format(inputText);

            TestTools.expect(actualText, equals(expectedText));
        }
    );

    test('If-statement with single-line block still gets expanded', ()
        {
            const String inputText = 'void f(){if(c){x;}}';
            const String expectedText = 'void f()\n{\n    if (c) \n    {\n        x;\n    }\n}\n';

            final String actualText = formatterAll.format(inputText);

            TestTools.expect(actualText, equals(expectedText));
        }
    );
}