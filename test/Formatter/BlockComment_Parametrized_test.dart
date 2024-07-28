import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Data/Triple.dart';
import 'package:dart_format/src/Data/Tuple.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:dart_format/src/Tools/LogTools.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    const String INDENT = '        ';

    TestTools.init();

    final Config configAll = Config.all();
    final Formatter formatterAll = Formatter(configAll);

    final Map<String, Triple<String, String, String>> indentationSets = <String, Triple<String, String, String>>
    {
        '1 No indent': const Triple<String, String, String>('', '', ''),
        '2 Start indented': const Triple<String, String, String>(INDENT, '', ''),
        '3 Middle indented': const Triple<String, String, String>('', INDENT, ''),
        '4 End indented': const Triple<String, String, String>('', '', INDENT)
    };

    final Map<String, Triple<String, String, String>> contexts = <String, Triple<String, String, String>>
    {
        '1 Top level': const Triple<String, String, String>('', '', ''),
        '2 Function': const Triple<String, String, String>('void f()\n{\n', '}\n', '    ')
    };

    final Map<String, Tuple<String, String>> statementSets = <String, Tuple<String, String>>
    {
        '1 Standalone': const Tuple<String, String>('', ''),
        '2 After statement': const Tuple<String, String>('var a;', ''),
        '3 Between statements': const Tuple<String, String>('var a;', 'var b;'),
        '4 Before statement': const Tuple<String, String>('', 'var b;')
    };

    group('Block comments parametrized', ()
        {
            for (final String indentationsName in indentationSets.keys)
            {
                final Triple<String, String, String> indentations = indentationSets[indentationsName]!;
                final String indentationStart = indentations.item1;
                final String indentationMiddle = indentations.item2;
                final String indentationEnd = indentations.item3;

                group(indentationsName, ()
                    {                
                        for (final String statementsName in statementSets.keys)
                        {
                            final Tuple<String, String> statements = statementSets[statementsName]!;
                            final String statementA = statements.item1;
                            final String statementB = statements.item2;

                            group(statementsName, ()
                                {                        
                                    for (final String contextName in contexts.keys)
                                    {
                                        final Triple<String, String, String> context = contexts[contextName]!;
                                        final String blockStart = context.item1;
                                        final String blockEnd = context.item2;
                                        final String blockIndentation = context.item3;

                                        group(contextName, ()
                                            {
                                                final String expectedIndentationStart = statementA.isEmpty ? '' : indentationStart;

                                                if (indentationMiddle.isEmpty)
                                                    test(r'/*\n*/', ()
                                                        {
                                                            final String inputText =
                                                                '$blockStart$blockIndentation$statementA$indentationStart/*\n'
                                                                '$blockIndentation$indentationEnd*/$statementB\n'
                                                                '$blockEnd';
                                                            final String expectedText =
                                                                '$blockStart$blockIndentation$statementA$expectedIndentationStart/*\n'
                                                                '$blockIndentation$indentationEnd*/$statementB\n'
                                                                '$blockEnd';

                                                            logDebug('inputText:\n$inputText');

                                                            final String actualText = formatterAll.format(inputText);

                                                            logDebug('inputText:\n$inputText');
                                                            logDebug('actualText:\n$actualText');
                                                            logDebug('expectedText:\n$expectedText');

                                                            TestTools.expect(actualText, equals(expectedText));
                                                        }
                                                    );

                                                test(r'/*\n*//*\n*/', ()
                                                    {
                                                        final String inputText =
                                                            '$blockStart$blockIndentation$statementA$indentationStart/*\n'
                                                            '$blockIndentation$indentationMiddle*//*\n'
                                                            '$blockIndentation$indentationEnd*/$statementB\n'
                                                            '$blockEnd';
                                                        final String expectedText =
                                                            '$blockStart$blockIndentation$statementA$expectedIndentationStart/*\n'
                                                            '$blockIndentation$indentationMiddle*//*\n'
                                                            '$blockIndentation$indentationEnd*/$statementB\n'
                                                            '$blockEnd';

                                                        logDebug('inputText:\n$inputText');

                                                        final String actualText = formatterAll.format(inputText);

                                                        logDebug('inputText:\n$inputText');
                                                        logDebug('actualText:\n$actualText');
                                                        logDebug('expectedText:\n$expectedText');

                                                        TestTools.expect(actualText, equals(expectedText));
                                                    }
                                                );
                                            }
                                        );
                                    }
                                }
                            );
                        }
                    }
                );
            }
        }
    );
}
