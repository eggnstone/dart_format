import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../TestTools/TestParameters.dart';
import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    late Config config = Config.none();
    late Formatter formatter = Formatter(config);
    late String afterSemicolonText;

    for (final bool alreadyFormatted in TestParameters.bools)
        for (final bool afterSemicolon in TestParameters.bools)
            group('Mixed tests (${alreadyFormatted ? 'AlreadyFormatted' : 'NeedsFormatting'}, '
                '${afterSemicolon ? ';' : '_'})', ()
                {
                    setUp(()
                        {
                            afterSemicolonText = afterSemicolon ? '\n' : '';
                            config = Config.none(addNewLineAfterSemicolon: afterSemicolon);
                            formatter = Formatter(config);
                        }
                    );

                    test('Import before class', ()
                        {
                            final String expectedText = "import 'a.dart';${afterSemicolonText}class C{}";
                            final String inputText = alreadyFormatted ? expectedText : "import 'a.dart';class C{}";

                            final String actualText = formatter.format(inputText);

                            TestTools.expect(actualText, equals(expectedText));
                        }
                    );
                }
            );
}
