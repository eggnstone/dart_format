import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/NamedExpressionFormatter.dart';

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
            inputNodeCreator: AstCreator.createNamedExpressionInArgumentList,
            inputLeading: 'void f(){g(',
            inputMiddle: 'n:1',
            inputTrailing: ');}',
            name: 'NamedExpression',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<Label>(11, 'n:'),
                TestVisitor<IntegerLiteral>(13, '1')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('n: 1')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'NamedExpressionFormatter', NamedExpressionFormatter.new, StackTrace.current);
}
