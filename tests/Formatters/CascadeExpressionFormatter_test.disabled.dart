/*
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
            inputNodeCreator: AstCreator.createCascadeExpressionInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'C\n..c()',
            inputTrailing: ';}',
            name: r'CascadeExpression / C\n..c()',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(9, 'C'),
                TestVisitor<MethodInvocation>(11, '..c()')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('C\n    ..c()')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createCascadeExpressionInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'C\n..a()\n..b()',
            inputTrailing: ';}',
            name: r'CascadeExpression / C\n..a()\n..b()',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(9, 'C'),
                TestVisitor<MethodInvocation>(11, '..a()'),
                TestVisitor<MethodInvocation>(17, '..b()')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('C\n    ..a()\n    ..b()')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'CascadeExpressionFormatter', CascadeExpressionFormatter.new, StackTrace.current);
}
*/
