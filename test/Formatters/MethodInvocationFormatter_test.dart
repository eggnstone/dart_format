import 'package:dart_format/src/Formatters/MethodInvocationFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestArgumentListVisitor.dart';
import '../TestTools/Visitors/TestAstVisitor.dart';
import '../TestTools/Visitors/TestSimpleIdentifierVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createExpressionInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'm()',
            inputTrailing: ';}',
            name: 'MethodInvocation',
            astVisitors: <TestAstVisitor>[
                TestSimpleIdentifierVisitor(9, 'm'),
                TestArgumentListVisitor(10, '()')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createExpressionInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'm.n()',
            inputTrailing: ';}',
            name: 'MethodInvocation',
            astVisitors: <TestAstVisitor>[
                TestSimpleIdentifierVisitor(9, 'm'),
                TestSimpleIdentifierVisitor(11, 'n'),
                TestArgumentListVisitor(12, '()')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'MethodInvocationFormatter', MethodInvocationFormatter.new, StackTrace.current);
}
