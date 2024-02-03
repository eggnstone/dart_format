import 'package:dart_format/dart_format.dart';
import 'package:test/test.dart';

import '../../../TestTools/TestParameters.dart';
import '../../../TestTools/TestTools.dart';

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

    for (final bool alreadyFormatted in TestParameters.bools)
        for (final bool beforeOpening in TestParameters.bools)
            for (final bool afterOpening in TestParameters.bools)
                for (final bool beforeClosing in TestParameters.bools)
                    for (final bool afterClosing in TestParameters.bools)
                        group('FunctionDeclarations (${alreadyFormatted ? 'AlreadyFormatted' : 'NeedsFormatting'}, '
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

                                test('Empty function', ()
                                    {
                                        final String expectedText = 'void f()$beforeOpeningText{$combinedInnerText}$afterClosingText';
                                        final String inputText = alreadyFormatted ? expectedText : 'void f(){}';

                                        final String actualText = formatter.format(inputText);

                                        TestTools.expect(actualText, equals(expectedText));
                                    }
                                );

                                test('Empty annotated function', ()
                                    {
                                        final String expectedText = '@a void f()$beforeOpeningText{$combinedInnerText}$afterClosingText';
                                        final String inputText = alreadyFormatted ? expectedText : '@a void f(){}';

                                        final String actualText = formatter.format(inputText);

                                        TestTools.expect(actualText, equals(expectedText));
                                    }
                                );
                            }
                        );
}
