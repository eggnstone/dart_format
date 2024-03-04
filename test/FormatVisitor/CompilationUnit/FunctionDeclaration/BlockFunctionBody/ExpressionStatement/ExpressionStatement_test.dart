import 'package:dart_format/dart_format.dart';
import 'package:test/test.dart';

import '../../../../../TestTools/TestParameters.dart';
import '../../../../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    late Config config = Config.none();
    late Formatter formatter = Formatter(config);
    late String afterSemicolonText;

    for (final bool alreadyFormatted in TestParameters.bools)
        for (final bool afterSemicolon in TestParameters.bools)
            group('ExpressionStatements (${alreadyFormatted ? 'AlreadyFormatted' : 'NeedsFormatting'}, ${afterSemicolon ? 'aS' : '_'})', ()
                {
                    setUp(()
                        {
                            afterSemicolonText = afterSemicolon ? '\n' : '';
                            config = Config.none(addNewLineAfterSemicolon: afterSemicolon);
                            formatter = Formatter(config);
                        }
                    );

                    test('Simple expression statement', ()
                        {
                            final String expectedText = 'void f(){a;$afterSemicolonText}';
                            final String inputText = alreadyFormatted ? expectedText : 'void f(){a;}';

                            final String actualText = formatter.format(inputText);

                            TestTools.expect(actualText, equals(expectedText));
                        }
                    );

                    test('2 simple expression statements', ()
                        {
                            final String expectedText = 'void f(){a;${afterSemicolonText}b;$afterSemicolonText}';
                            final String inputText = alreadyFormatted ? expectedText : 'void f(){a;b;}';

                            final String actualText = formatter.format(inputText);

                            TestTools.expect(actualText, equals(expectedText));
                        }
                    );
                }
            );
}
