import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/InterpolationExpressionFormatter.dart';

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
            inputNodeCreator: AstCreator.createInterpolationExpressionInVariable,
            inputLeading: r"void f(int n){var s = 'a",
            inputMiddle: r'${n}',
            inputTrailing: "b';}",
            name: 'InterpolationExpression with braces',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(26, 'n')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig(r'${n}')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'InterpolationExpressionFormatter', InterpolationExpressionFormatter.new, StackTrace.current);
}
