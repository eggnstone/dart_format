import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('Block comments in map', ()
        {
            test('Block comment without trailing comma', ()
                {
                    const String inputText =
                        'var m =\n'
                        '    {\n'
                        '        a\n'
                        '        /* Comment */\n'
                        '    };\n';
                    const String expectedText = inputText;

                    final Config config = Config.all();
                    final Formatter formatter = Formatter(config);

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('Block comment with trailing comma, without removal', ()
                {
                    const String inputText =
                        'var m =\n'
                        '    {\n'
                        '        a,\n'
                        '        /* Comment */\n'
                        '    };\n';
                    const String expectedText = inputText;

                    final Config config = Config.all(removeTrailingCommas: false);
                    final Formatter formatter = Formatter(config);

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('Block comment with trailing comma, with removal', ()
                {
                    const String inputText =
                        'var m =\n'
                        '    {\n'
                        '        a,\n'
                        '        /* Comment */\n'
                        '    };\n';
                    const String expectedText =
                        'var m =\n'
                        '    {\n'
                        '        a\n'
                        '        /* Comment */\n'
                        '    };\n';

                    final Config config = Config.all();
                    final Formatter formatter = Formatter(config);

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );
        }
    );
}
