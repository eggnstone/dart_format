import 'package:dart_format/src/Formatters/ExpressionFormatters/PostfixExpressionFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestAstVisitor.dart';
import '../TestTools/Visitors/TestSimpleIdentifierVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createExpressionInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'i++',
            inputTrailing: ';}',
            name: 'PostfixExpression',
            astVisitors: <TestAstVisitor>[
                TestSimpleIdentifierVisitor(9, 'i')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'PostfixExpressionFormatter', PostfixExpressionFormatter.new, StackTrace.current);
}
