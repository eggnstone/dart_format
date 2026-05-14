import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/IsExpressionFormatter.dart';

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
            inputNodeCreator: AstCreator.createIsExpressionInVariable,
            inputLeading: 'void f(){var x = ',
            inputMiddle: 'a  is  B',
            inputTrailing: ';}',
            name: 'IsExpression',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(17, 'a'),
                TestVisitor<NamedType>(24, 'B')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('a is B')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createIsExpressionInVariable,
            inputLeading: 'void f(){var x = ',
            inputMiddle: 'a  is!  B',
            inputTrailing: ';}',
            name: 'IsExpression negated',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(17, 'a'),
                TestVisitor<NamedType>(25, 'B')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('a is! B')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'IsExpressionFormatter', IsExpressionFormatter.new, StackTrace.current);
}
