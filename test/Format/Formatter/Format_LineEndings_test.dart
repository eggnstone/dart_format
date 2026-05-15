import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Format/Formatter.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config config = Config.experimental();
    final Formatter formatter = Formatter(config);

    group('Formatter.format: line endings', ()
        {
            test('CRLF input keeps CRLF in output', ()
                {
                    const String inputText = 'void F()\r\n{\r\n    V;\r\n}\r\n';
                    const String expectedText = 'void F()\r\n{\r\n    V;\r\n}\r\n';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('LF input keeps LF in output', ()
                {
                    const String inputText = 'void F()\n{\n    V;\n}\n';
                    const String expectedText = 'void F()\n{\n    V;\n}\n';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('CRLF input with reformatting keeps CRLF in output', ()
                {
                    const String inputText = 'void F(){V;}';
                    const String expectedText = 'void F()\r\n{\r\n    V;\r\n}\r\n';

                    final String actualText = formatter.format('${inputText.replaceAll('\n', '\r\n')}\r\n');

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('Mixed input with any CRLF uses CRLF in output', ()
                {
                    const String inputText = 'void F()\r\n{\n    V;\r\n}\n';
                    const String expectedText = 'void F()\r\n{\r\n    V;\r\n}\r\n';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
