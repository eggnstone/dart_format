import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config configNone = Config.none();
    final Formatter formatterNone = Formatter(configNone);

    group('DocComments', ()
        {
            test('Normal comments and DocComments mixed', ()
                {
                    const String inputText =
                        'class C\n'
                        '{\n'
                        '/// DocCommentOnly\n'
                        'bool docCommentOnly = true;\n'
                        '// NormalCommentOnly\n'
                        'bool normalCommentOnly = true;\n'
                        '/// DocComment1\n'
                        '// NormalComment2\n'
                        'bool docFirstThenNormal = true;\n'
                        '// NormalComment1\n'
                        '/// DocComment2\n'
                        'bool normalFirstThenDoc = true;\n'
                        '}';
                    const String expectedText = inputText;

                    final String actualText = formatterNone.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );

            test('DocComment with reference', ()
                {
                    const String inputText =
                        'class C\n'
                        '{\n'
                        '/// Start [SomeReference] End\n'
                        'bool b = true;\n'
                        '}';
                    const String expectedText = inputText;

                    final String actualText = formatterNone.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                }
            );
        }
    );
}
