import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/MethodInvocationFormatter.dart';

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
            inputNodeCreator: AstCreator.createMethodInvocationInExpressionStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'C\n.a()',
            inputTrailing: ';}',
            name: r'MethodInvocation / C\n.a()',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(9, 'C'),
                TestVisitor<SimpleIdentifier>(12, 'a'),
                TestVisitor<ArgumentList>(13, '()')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('C\n    .a()')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createMethodInvocationInExpressionStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'C\n.a()\n.b()',
            inputTrailing: ';}',
            name: r'MethodInvocation / C\n.a()\n.b()',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<MethodInvocation>(9, 'C\n.a()'),
                TestVisitor<SimpleIdentifier>(17, 'b'),
                TestVisitor<ArgumentList>(18, '()')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('C\n.a()\n    .b()')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createMethodInvocationInExpressionStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'C.c((){})',
            inputTrailing: ';}',
            name: 'MethodInvocation / C.c((){})',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(9, 'C'),
                TestVisitor<SimpleIdentifier>(11, 'c'),
                TestVisitor<ArgumentList>(12, '((){})')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'MethodInvocationFormatter', MethodInvocationFormatter.new, StackTrace.current);
}
