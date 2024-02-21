import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/ForPartsWithExpressionFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createForLoopPartsInForStatementInFunction,
            inputLeading: 'void f(){for(',
            inputMiddle: ';;i++,j--',
            inputTrailing: ');}',
            name: 'ForPartsWithExpression ;;i++,j--',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<PostfixExpression>(15, 'i++'),
                TestVisitor<PostfixExpression>(19, 'j--')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'ForPartsWithExpressionFormatter', ForPartsWithExpressionFormatter.new, StackTrace.current);
}
