import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/ArgumentListFormatter.dart';

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
            inputNodeCreator: AstCreator.createArgumentListInMethodInvocationInFunction,
            inputLeading: 'void f(){g',
            inputMiddle: '(a:1,b:2,)',
            inputTrailing: ';}',
            name: 'ArgumentList (only named arguments)',
            astVisitors: <TestVisitor<AstNode>>[
                TestVisitor<NamedExpression>(11, 'a:1'),
                TestVisitor<NamedExpression>(15, 'b:2')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('(a:1,b:2)')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createArgumentListInMethodInvocationInFunction,
            inputLeading: 'void f(){g',
            inputMiddle: '(1,b:2,3,d:4,)',
            inputTrailing: ';}',
            name: 'ArgumentList (positional and named arguments mixed 1)',
            astVisitors: <TestVisitor<AstNode>>[
                TestVisitor<IntegerLiteral>(11, '1'),
                TestVisitor<NamedExpression>(13, 'b:2'),
                TestVisitor<IntegerLiteral>(17, '3'),
                TestVisitor<NamedExpression>(19, 'd:4')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('(1,b:2,3,d:4)')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createArgumentListInMethodInvocationInFunction,
            inputLeading: 'void f(){g',
            inputMiddle: '(a:1,2,c:3,4,)',
            inputTrailing: ';}',
            name: 'ArgumentList (positional and named arguments mixed 2)',
            astVisitors: <TestVisitor<AstNode>>[
                TestVisitor<NamedExpression>(11, 'a:1'),
                TestVisitor<IntegerLiteral>(15, '2'),
                TestVisitor<NamedExpression>(17, 'c:3'),
                TestVisitor<IntegerLiteral>(21, '4')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('(a:1,2,c:3,4)')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'ArgumentListFormatter', ArgumentListFormatter.new, StackTrace.current);
}
