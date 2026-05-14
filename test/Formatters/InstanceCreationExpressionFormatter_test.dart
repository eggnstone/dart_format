import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/InstanceCreationExpressionFormatter.dart';

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
            inputNodeCreator: AstCreator.createInstanceCreationExpressionInVariable,
            inputLeading: 'void f(){var x = ',
            inputMiddle: 'new  C()',
            inputTrailing: ';}',
            name: 'InstanceCreationExpression with new keyword',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<ConstructorName>(22, 'C'),
                TestVisitor<ArgumentList>(23, '()')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('new C()')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createInstanceCreationExpressionInVariable,
            inputLeading: 'void f(){var x = ',
            inputMiddle: 'const C()',
            inputTrailing: ';}',
            name: 'InstanceCreationExpression with const keyword',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<ConstructorName>(23, 'C'),
                TestVisitor<ArgumentList>(24, '()')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('const C()')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'InstanceCreationExpressionFormatter', InstanceCreationExpressionFormatter.new, StackTrace.current);
}
