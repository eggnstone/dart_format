import 'package:dart_format/dart_format.dart';
import 'package:dart_format/src/Analyzer.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('Comments', ()
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

                    Analyzer().analyze(inputText);

                    const Config config = Config.none();
                    final Formatter formatter = Formatter(config);
                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(inputText));
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

                    Analyzer().analyze(inputText);

                    const Config config = Config.none();
                    final Formatter formatter = Formatter(config);
                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(inputText));
                }
            );
        }
    );
}
