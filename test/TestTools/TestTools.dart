import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Config.dart';
import 'package:dart_format/src/Constants/Constants.dart';
import 'package:dart_format/src/FormatState.dart';
import 'package:dart_format/src/FormatVisitor.dart';
import 'package:dart_format/src/Formatters/IFormatter.dart';
import 'package:dart_format/src/Tools/FormatTools.dart';
import 'package:dart_format/src/Tools/LogTools.dart';
import 'package:dart_format/src/Tools/StringTools.dart';
import 'package:test/test.dart' as Test; // ignore: library_prefixes

import 'TestConfig.dart';
import 'TestGroupConfig.dart';
import 'TestParseStringResult.dart';
import 'Visitors/MetaAstVisitor.dart';
import 'Visitors/TestAstVisitor.dart';

// TODO: why use LogTools instead of eggnstone_dart?

typedef CreateFormatterFunction = IFormatter Function(Config config, AstVisitor<void> astVisitor, FormatState formatState);
typedef FormatFunction = String Function(FormatState formatState, TestGroupConfig testGroupConfig, TestConfig testConfig, AstNode node);

class TestTools
{
    static void init()
    {
        LogTools.logInternals = true;
        LogTools.logToConsole = true;
        LogTools.logToTempFile = false;
    }

    static void expect(String actual, Test.Matcher matcher, {StackTrace? alternativeStackTrace, String? reason})
    {
        try
        {
            Test.expect(actual, matcher, reason: reason);
            // TODO: why use logInternalInfo instead of logInfo?
            logInternalInfo('OK: ${StringTools.toDisplayString(actual, Constants.MAX_DEBUG_LENGTH)}');
        }
        on Test.TestFailure catch (e)
        {
            if (alternativeStackTrace == null)
                rethrow;

            // ignore: only_throw_errors
            throw (e, alternativeStackTrace);
        }
    }

    static void runTestGroup(TestGroupConfig testGroupConfig, {CreateFormatterFunction? createFormatterFunction, String? name, StackTrace? stackTrace, List<TestAstVisitor>? astVisitors})
    {
        final String testGroupConfigName = testGroupConfig.name ?? '<Default>';
        final String groupName = name == null ? testGroupConfigName : '$name: $testGroupConfigName';
        final StackTrace finalStackTrace = stackTrace ?? StackTrace.current;

        Test.group(groupName, ()
            {
                final String inputText = '${testGroupConfig.inputLeading}${testGroupConfig.inputMiddle}${testGroupConfig.inputTrailing}';
                final AstNode inputNode = testGroupConfig.getInputNode();
                final List<TestConfig> testConfigs = testGroupConfig.testConfigs ?? <TestConfig>[TestConfig.none(), TestConfig()];
                for (final TestConfig testConfig in testConfigs)
                    Test.test('Config: ${testConfig.name}', ()
                        {
                            final ParseStringResult parseResult = TestParseStringResult(content: inputText, unit: inputNode.root as CompilationUnit);
                            final FormatState formatState = FormatState.test(parseResult, indentationSpacesPerLevel: testConfig.config.indentationSpacesPerLevel, leading: testGroupConfig.inputLeading, trailing: testGroupConfig.inputTrailing);
                            final MetaAstVisitor astVisitor = MetaAstVisitor(astVisitors, formatState);
                            final IFormatter? formatter = createFormatterFunction?.call(testConfig.config, astVisitor, formatState);

                            final String actualText;
                            try
                            {
                                FormatFunction finalFormatFunction = _useFormatVisitor;
                                if (formatter != null)
                                    finalFormatFunction = (FormatState formatState, TestGroupConfig testGroupConfig, TestConfig testConfig, AstNode node) => _useIFormatter(formatter, formatState, testGroupConfig, testConfig, node);

                                actualText = finalFormatFunction(formatState, testGroupConfig, testConfig, inputNode);
                            }
                            catch (e)
                            {
                                // TODO: why use logInternalError instead of logError?
                                logInternalError('AlternativeStackTrace:\n$finalStackTrace');
                                rethrow;
                            }

                            final String actualTextWithoutIgnore = FormatTools.removeIgnoreTagsCompletely(actualText);
                            TestTools.expect(actualTextWithoutIgnore, Test.equals(testConfig.expectedText ?? testGroupConfig.inputMiddle), alternativeStackTrace: finalStackTrace);

                            Test.expect(astVisitor.currentVisitorIndex, Test.equals(astVisitors?.length ?? 0), reason: 'Not all expected visitors called.');

                            final String remainingText = formatState.getText(formatState.lastConsumedPosition, inputText.length);
                            TestTools.expect(remainingText, Test.equals(testConfig.restText ?? testGroupConfig.inputTrailing), alternativeStackTrace: finalStackTrace, reason: 'Remaining text does not match.');
                        }
                    );
            }
        );
    }

    static void runTestGroups(List<TestGroupConfig> testGroupConfigs, String name)
    {
        final StackTrace stackTrace = StackTrace.current;

        Test.group(name, ()
            {
                for (final TestGroupConfig testGroupConfig in testGroupConfigs)
                    runTestGroup(testGroupConfig, name: name, stackTrace: stackTrace);
            }
        );
    }

    static void runTestGroupsForFormatter(List<TestGroupConfig> testGroupConfigs, String name, CreateFormatterFunction f, StackTrace stackTrace)
    {
        Test.group(name, ()
            {
                for (final TestGroupConfig testGroupConfig in testGroupConfigs)
                    runTestGroup(testGroupConfig, createFormatterFunction: f, stackTrace: stackTrace, astVisitors: testGroupConfig.astVisitors);
            }
        );
    }

    static String _useFormatVisitor(FormatState formatState, TestGroupConfig testGroupConfig, TestConfig testConfig, AstNode node)
    {
        final FormatVisitor formatVisitor = FormatVisitor(config: testConfig.config, formatState: formatState);
        final String inputText = '${testGroupConfig.inputLeading}${testGroupConfig.inputMiddle}${testGroupConfig.inputTrailing}';

        //testGroupConfig.getInputNode().accept(formatVisitor);
        node.accept(formatVisitor);
        formatState.consumeTill(inputText.length, 'TEST');

        return formatState.getResult();
    }

    static String _useIFormatter(IFormatter formatter, FormatState formatState, TestGroupConfig testGroupConfig, TestConfig testConfig, AstNode node)
    {
        //formatter.format(testGroupConfig.getInputNode());
        formatter.format(node);
        return formatState.getResult();
    }
}
