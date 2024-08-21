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
            test('No indents', ()
                {
                    const String inputText = "var s=\n'''abc\nxyz''';";
                    const String expectedText = "var s=\n    '''abc\nxyz''';\n";

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Indents preserved', ()
                {
                    const String inputText = "var s=\n'''abc\nMIDDLE\n        xyz''';";
                    const String expectedText = "var s=\n    '''abc\nMIDDLE\n        xyz''';\n";

                    final String actualText = formatterAll.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
