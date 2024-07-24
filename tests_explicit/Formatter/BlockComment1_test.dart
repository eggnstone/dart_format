import 'package:dart_format/dart_format.dart';
import 'package:dart_format/src/Analyzer.dart';
import 'package:dart_format/src/Tools/StringTools.dart';
import 'package:eggnstone_dart/eggnstone_dart.dart';
import 'package:test/test.dart';

import '../../tests/TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('Block comments in function and map blocks', ()
        {
            test('Block comment in a function block', ()
                {
                    const String inputText = 
                        'void f()\n'
                        '{\n'
                        '    a;\n'
                        '    /*Comment*/\n'
                        '}\n';
                    const String expectedText = inputText;

                    Analyzer().analyze(inputText);

                    final Config config = Config.all();
                    final Formatter formatter = Formatter(config);

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('Block comment without trailing comma', ()
                {
                    const String inputText =
                        'var m =\n'
                        '    {\n'
                        '        a\n'
                        '        /*Comment*/\n'
                        '    };\n';
                    const String expectedText = inputText;

                    Analyzer().analyze(inputText);

                    final Config config = Config.all();
                    final Formatter formatter = Formatter(config);

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('Block comment with trailing comma, without removal', ()
                {
                    const String inputText =
                        'var m =\n'
                        '    {\n'
                        '        a,\n'
                        '        /*Comment*/\n'
                        '    };\n';
                    const String expectedText = inputText;

                    Analyzer().analyze(inputText);

                    final Config config = Config.all(removeTrailingCommas: false);
                    final Formatter formatter = Formatter(config);

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test('Block comment with trailing comma, with removal', ()
                {
                    const String inputText =
                        'var m =\n'
                        '    {\n'
                        '        a,\n'
                        '        /*Comment*/\n'
                        '    };\n';

                    const String expectedText =
                        'var m =\n'
                        '    {\n'
                        '        a\n'
                        '        /*Comment*/\n'
                        '    };\n';

                    Analyzer().analyze(inputText);

                    final Config config = Config.all();
                    final Formatter formatter = Formatter(config);

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );
        }
    );
}
