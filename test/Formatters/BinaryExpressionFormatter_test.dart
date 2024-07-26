import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/BinaryExpressionFormatter.dart';

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
            inputNodeCreator: AstCreator.createBinaryExpressionInTopLevelVariable,
            inputLeading: 'bool b = ',
            inputMiddle: 'true\n&& false',
            inputTrailing: ';',
            name: 'Multiline BinaryExpression',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<BooleanLiteral>(9, 'true'),
                TestVisitor<BooleanLiteral>(17, 'false')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('true\n    && false')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'BinaryExpressionFormatter', BinaryExpressionFormatter.new, StackTrace.current);
}
