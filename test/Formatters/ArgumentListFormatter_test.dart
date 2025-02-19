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
            inputNodeCreator: AstCreator.createArgumentListInFunction,
            inputLeading: 'void f(){g',
            inputMiddle: '(1,b:2)',
            inputTrailing: ';}',
            name: '(1,b:2) (too little spacing)',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<IntegerLiteral>(11, '1'),
                TestVisitor<NamedExpression>(13, 'b:2'),
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                //TODO: TestConfig('(1, b:2)')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createArgumentListInFunction,
            inputLeading: 'void f(){g',
            inputMiddle: '(  1  ,  b  :  2  )',
            inputTrailing: ';}',
            name: '(1,b:2) (too much spacing)',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<IntegerLiteral>(13, '1'),
                TestVisitor<NamedExpression>(19, 'b  :  2'),
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                //TODO: TestConfig('(1, b:  2)')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'ArgumentListFormatter', ArgumentListFormatter.new, StackTrace.current);
}
