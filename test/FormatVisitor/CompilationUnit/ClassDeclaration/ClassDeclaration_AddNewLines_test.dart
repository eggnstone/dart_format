import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../../../TestTools/TestParameters.dart';
import '../../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    late Config config = Config.none();
    late Formatter formatter = Formatter(config);
    late String beforeOpeningText;
    late String afterOpeningText;
    late String beforeClosingText;
    late String afterClosingText;
    late String combinedInnerText;

    for (final bool alreadyFormatted in TestParameters.bools)
        for (final bool beforeOpening in TestParameters.bools)
            for (final bool afterOpening in TestParameters.bools)
                for (final bool beforeClosing in TestParameters.bools)
                    for (final bool afterClosing in TestParameters.bools)
                        group('ClassDeclarations (${alreadyFormatted ? 'AlreadyFormatted' : 'NeedsFormatting'}, '
                            '${beforeOpening ? 'bO' : '_'}'
                            '${afterOpening ? 'aO' : '_'}'
                            '${beforeClosing ? 'bC' : '_'}'
                            '${afterClosing ? 'aC' : '_'})', ()
                            {
                                setUp(()
                                    {
                                        beforeOpeningText = beforeOpening ? '\n' : '';
                                        afterOpeningText = afterOpening ? '\n' : '';
                                        beforeClosingText = beforeClosing ? '\n' : '';
                                        afterClosingText = afterClosing ? '\n' : '';
                                        combinedInnerText = afterOpening && beforeClosing ? '\n' : '$afterOpeningText$beforeClosingText';

                                        config = Config.none(
                                            addNewLineBeforeOpeningBrace: beforeOpening,
                                            addNewLineAfterOpeningBrace: afterOpening,
                                            addNewLineBeforeClosingBrace: beforeClosing,
                                            addNewLineAfterClosingBrace: afterClosing
                                        );

                                        formatter = Formatter(config);
                                    }
                                );

                                test('Empty class declaration with comment inside', ()
                                    {
                                        final String expectedText = 'class C$beforeOpeningText{$afterOpeningText/**/$beforeClosingText}$afterClosingText';
                                        final String inputText = alreadyFormatted ? expectedText : 'class C{/**/}';

                                        final String actualText = formatter.format(inputText);

                                        TestTools.expect(actualText, equals(expectedText));
                                    }
                                );

                                test('Empty class declaration', ()
                                    {
                                        final String expectedText = 'class C$beforeOpeningText{$combinedInnerText}$afterClosingText';
                                        final String inputText = alreadyFormatted ? expectedText : 'class C{}';

                                        final String actualText = formatter.format(inputText);

                                        TestTools.expect(actualText, equals(expectedText));
                                    }
                                );

                                test('Empty annotated (1) class declaration', ()
                                    {
                                        final String expectedText = '@a class C$beforeOpeningText{$combinedInnerText}$afterClosingText';
                                        final String inputText = alreadyFormatted ? expectedText : '@a class C{}';

                                        final String actualText = formatter.format(inputText);

                                        TestTools.expect(actualText, equals(expectedText));
                                    }
                                );

                                test('Empty annotated (2 with space) class declaration', ()
                                    {
                                        final String expectedText = '@a @b class C$beforeOpeningText{$combinedInnerText}$afterClosingText';
                                        final String inputText = alreadyFormatted ? expectedText : '@a @b class C{}';

                                        final String actualText = formatter.format(inputText);

                                        TestTools.expect(actualText, equals(expectedText));
                                    }
                                );

                                test('Empty annotated (2 without space) class declaration', ()
                                    {
                                        final String expectedText = '@a@b class C$beforeOpeningText{$combinedInnerText}$afterClosingText';
                                        final String inputText = alreadyFormatted ? expectedText : '@a@b class C{}';

                                        final String actualText = formatter.format(inputText);

                                        TestTools.expect(actualText, equals(expectedText));
                                    }
                                );

                                test('Empty extended class declaration', ()
                                    {
                                        final String expectedText = 'class C extends E$beforeOpeningText{$combinedInnerText}$afterClosingText';
                                        final String inputText = alreadyFormatted ? expectedText : 'class C extends E{}';

                                        final String actualText = formatter.format(inputText);

                                        TestTools.expect(actualText, equals(expectedText));
                                    }
                                );
                            }
                        );
}
