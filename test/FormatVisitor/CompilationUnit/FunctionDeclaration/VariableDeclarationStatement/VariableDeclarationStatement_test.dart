import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../../../../TestTools/TestParameters.dart';
import '../../../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    late Config config = Config.none();
    late Formatter formatter = Formatter(config);
    late String afterSemicolonText;

    for (final bool alreadyFormatted in TestParameters.bools)
        for (final bool afterSemicolon in TestParameters.bools)
            group('VariableDeclarationStatements (${alreadyFormatted ? 'AlreadyFormatted' : 'NeedsFormatting'}, ${afterSemicolon ? 'aS' : '_'})', ()
                {
                    setUp(()
                        {
                            afterSemicolonText = afterSemicolon ? '\n' : '';
                            config = Config.none(addNewLineAfterSemicolon: afterSemicolon);
                            formatter = Formatter(config);
                        }
                    );

                    test('Simple variable declaration', ()
                        {
                            final String expectedText = 'void f(){int i;$afterSemicolonText}';
                            final String inputText = alreadyFormatted ? expectedText : 'void f(){int i;}';

                            final String actualText = formatter.format(inputText);

                            TestTools.expect(actualText, equals(expectedText));
                        }
                    );

                    test('2 simple variable declarations', ()
                        {
                            final String expectedText = 'void f(){int i;${afterSemicolonText}int j;$afterSemicolonText}';
                            final String inputText = alreadyFormatted ? expectedText : 'void f(){int i;int j;}';

                            final String actualText = formatter.format(inputText);

                            TestTools.expect(actualText, equals(expectedText));
                        }
                    );
                }
            );
}
