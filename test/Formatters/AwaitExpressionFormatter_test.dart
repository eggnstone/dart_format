import 'package:dart_format/src/Formatters/ExpressionFormatters/AwaitExpressionFormatter.dart';

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
            inputLeading: 'void f()async{',
            inputMiddle: 'await e',
            inputTrailing: ';}',
            name: 'AwaitExpression',
            astVisitors: <TestAstVisitor>[TestSimpleIdentifierVisitor(20, 'e')]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'AwaitExpressionFormatter', AwaitExpressionFormatter.new, StackTrace.current);
}
