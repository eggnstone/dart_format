import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/PostfixExpressionFormatter.dart';

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
            inputNodeCreator: AstCreator.createInitializerInTopLevelVariable,
            inputLeading: 'var x = ',
            inputMiddle: 'y  ++',
            inputTrailing: ';',
            name: r'PostfixExpression / f\n.a\n.b',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(8, 'y')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('y++')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'PostfixExpressionFormatter', PostfixExpressionFormatter.new, StackTrace.current);
}
