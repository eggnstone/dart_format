import 'package:dart_format/src/Formatters/ExpressionFormatters/FunctionExpressionFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestAstVisitor.dart';
import '../TestTools/Visitors/TestBlockFunctionBodyVisitor.dart';
import '../TestTools/Visitors/TestFormalParameterListVisitor.dart';
import '../TestTools/Visitors/TestTypeParameterListVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFunctionExpression,
            inputLeading: 'void f',
            inputMiddle: '<T>(int i){}',
            astVisitors: <TestAstVisitor>[
                TestTypeParameterListVisitor(6, '<T>'),
                TestFormalParameterListVisitor(9, '(int i)'),
                TestBlockFunctionBodyVisitor(16, '{}')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'FunctionExpressionFormatter', FunctionExpressionFormatter.new, StackTrace.current);
}
