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
    late String combinedInnerText;
    late String afterClosingBeforeClosingText;

    for (final bool alreadyFormatted in TestParameters.bools)
        for (final bool beforeOpening in TestParameters.bools)
            for (final bool afterOpening in TestParameters.bools)
                for (final bool beforeClosing in TestParameters.bools)
                    for (final bool afterClosing in TestParameters.bools)
                        group('MethodDeclarations (${alreadyFormatted ? 'AlreadyFormatted' : 'NeedsFormatting'}, '
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
                                        afterClosingBeforeClosingText = afterClosing && beforeClosing ? '\n' : '$afterClosingText$beforeClosingText';

                                        config = Config.none(
                                            addNewLineBeforeOpeningBrace: beforeOpening,
                                            addNewLineAfterOpeningBrace: afterOpening,
                                            addNewLineBeforeClosingBrace: beforeClosing,
                                            addNewLineAfterClosingBrace: afterClosing
                                        );

                                        formatter = Formatter(config);
                                    }
                                );

                                test('Empty method declaration', ()
                                    {
                                        final String expectedText = 'class C$beforeOpeningText{${afterOpeningText}void m()$beforeOpeningText{$combinedInnerText}$afterClosingBeforeClosingText}$afterClosingText';
                                        final String inputText = alreadyFormatted ? expectedText : 'class C{void m(){}}';

                                        final String actualText = formatter.format(inputText);

                                        TestTools.expect(actualText, equals(expectedText));
                                    }
                                );

                                test('Empty method declaration with comment inside', ()
                                    {
                                        final String expectedText = 'class C$beforeOpeningText{${afterOpeningText}void m()$beforeOpeningText{$afterOpeningText/**/$beforeClosingText}$afterClosingBeforeClosingText}$afterClosingText';
                                        final String inputText = alreadyFormatted ? expectedText : 'class C{void m(){/**/}}';

                                        final String actualText = formatter.format(inputText);

                                        TestTools.expect(actualText, equals(expectedText));
                                    }
                                );

                                test('Empty annotated method declaration', ()
                                    {
                                        final String expectedText = 'class C$beforeOpeningText{$afterOpeningText@a void m()$beforeOpeningText{$combinedInnerText}$afterClosingBeforeClosingText}$afterClosingText';
                                        final String inputText = alreadyFormatted ? expectedText : 'class C{@a void m(){}}';

                                        final String actualText = formatter.format(inputText);

                                        TestTools.expect(actualText, equals(expectedText));
                                    }
                                );
                            }
                        );
}
