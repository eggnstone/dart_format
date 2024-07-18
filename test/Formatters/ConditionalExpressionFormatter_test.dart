import 'package:analyzer/src/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/ConditionalExpressionFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestConfig.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestVisitor.dart';

void main()
{
    TestTools.init();

    final VariableDeclaration x = AstCreator.createVariableDeclarationInFunction('void f(){bool b = true\n? true\n: false;}');
    final Expression? y = x.initializer;

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createConditionalExpression,
            inputLeading: 'void f(){bool b = ',
            inputMiddle: 'true\n? true\n: false',
            inputTrailing: ';}',
            name: 'Multiline ConditionalExpression',
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('true\n    ? true\n    : false')
            ],
            astVisitors: <TestVisitor<void>>[
                TestVisitor<Expression>(18, 'true'),
                TestVisitor<Expression>(25, 'true'),
                TestVisitor<Expression>(32, 'false')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'ConditionalExpressionFormatter', ConditionalExpressionFormatter.new, StackTrace.current);
}
