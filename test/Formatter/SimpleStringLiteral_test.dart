import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config configAll = Config.all();
    final Formatter formatterAll = Formatter(configAll);

    group('Formatter.format: SimpleStringLiteral', ()
        {
            final Map<String, String> inputs =
                <String, String>
                {
                    '"""' : '"""',
                    'r""""' : '"""',
                    "'''": "'''",
                    "r'''": "'''"
                };

            inputs.forEach((String start, String end)
                {
                    test('No indents with $start/$end', ()
                        {
                            final String inputText = 'var s=\n${start}abc\nxyz$end;';
                            final String expectedText = 'var s=\n    ${start}abc\nxyz$end;\n';

                            final String actualText = formatterAll.format(inputText);

                            TestTools.expect(actualText, equals(expectedText));
                        }
                    );

                    test('No indents with $start/$end', ()
                        {
                            final String inputText = 'var s=\n${start}abc\nMIDDLE\n        xyz$end;';
                            final String expectedText = 'var s=\n    ${start}abc\nMIDDLE\n        xyz$end;\n';

                            final String actualText = formatterAll.format(inputText);

                            TestTools.expect(actualText, equals(expectedText));
                        }
                    );
                }
            );
        }
    );
}
