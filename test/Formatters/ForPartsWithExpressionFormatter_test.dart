
import 'package:dart_format/src/Formatters/ForPartsWithExpressionFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestAssignmentExpressionVisitor.dart';
import '../TestTools/Visitors/TestAstVisitor.dart';
import '../TestTools/Visitors/TestBinaryExpressionVisitor.dart';
import '../TestTools/Visitors/TestPostfixVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createForLoopPartsInForStatementInFunction,
            inputLeading: 'void f(){for(',
            inputMiddle: ';;',
            inputTrailing: ');}',
            name: 'ForPartsWithExpression / Simple'
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createForLoopPartsInForStatementInFunction,
            inputLeading: 'void f(){for(',
            inputMiddle: 'i=0;i<0;i++',
            inputTrailing: ');}',
            name: 'ForPartsWithExpression / With initializer, condition, and updater',
            astVisitors: <TestAstVisitor>[
                TestAssignmentExpressionVisitor(13, 'i=0'),
                TestBinaryExpressionVisitor(17, 'i<0'),
                TestPostfixExpressionVisitor(21, 'i++')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'ForPartsWithExpressionFormatter', ForPartsWithExpressionFormatter.new, StackTrace.current);
}
