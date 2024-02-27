import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/CascadeExpressionFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestConfig.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createCascadeExpressionInStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'a\n..[0]\n..[1]',
            inputTrailing: ';}',
            name: 'CascadeExpression',
            astVisitors: <TestVisitor<AstNode>>[
                TestVisitor<SimpleIdentifier>(9, 'a'),
                TestVisitor<IndexExpression>(11, '..[0]'),
                TestVisitor<IndexExpression>(17, '..[1]')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('a\n    ..[0]\n    ..[1]')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'CascadeExpressionFormatter', CascadeExpressionFormatter.new, StackTrace.current);
}
