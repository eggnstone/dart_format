import 'package:dart_format/dart_format.dart';
import 'package:test/test.dart';

import '../../../../TestTools/TestParameters.dart';
import '../../../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    late Config config = const Config.none();
    late Formatter formatter = Formatter(config);
    late String beforeOpeningText;
    late String afterOpeningText;
    late String beforeClosingText;
    late String afterClosingText;
    late String afterSemicolonText;
    late String afterSemicolonBeforeClosingText;

    for (final bool alreadyFormatted in TestParameters.bools)
        for (final bool beforeOpening in TestParameters.bools)
            for (final bool afterOpening in TestParameters.bools)
                for (final bool beforeClosing in TestParameters.bools)
                    for (final bool afterClosing in TestParameters.bools)
                        for (final bool afterSemicolon in TestParameters.bools)
                            group('ConstructorDeclarations (${alreadyFormatted ? 'AlreadyFormatted' : 'NeedsFormatting'}, '
                                '${afterSemicolon ? ';' : '_'})', ()
                                {
                                    setUp(()
                                        {
                                            beforeOpeningText = beforeOpening ? '\n' : '';
                                            afterOpeningText = afterOpening ? '\n' : '';
                                            beforeClosingText = beforeClosing ? '\n' : '';
                                            afterClosingText = afterClosing ? '\n' : '';
                                            afterSemicolonText = afterSemicolon ? '\n' : '';
                                            afterSemicolonBeforeClosingText = afterSemicolon && beforeClosing ? '\n' : '$afterSemicolonText$beforeClosingText';

                                            config = Config.none(
                                                addNewLineAfterClosingBrace: afterClosing,
                                                addNewLineAfterOpeningBrace: afterOpening,
                                                addNewLineBeforeClosingBrace: beforeClosing,
                                                addNewLineBeforeOpeningBrace: beforeOpening,
                                                addNewLineAfterSemicolon: afterSemicolon
                                            );

                                            formatter = Formatter(config);
                                        }
                                    );

                                    test('Empty const constructor', ()
                                        {
                                            final String expectedText =  'class C$beforeOpeningText{${afterOpeningText}const C();$afterSemicolonBeforeClosingText}$afterClosingText';
                                            final String inputText = alreadyFormatted ? expectedText : 'class C{const C();}';

                                            final String actualText = formatter.format(inputText);

                                            TestTools.expect(actualText, equals(expectedText));
                                        }
                                    );
                                }
                            );
}
