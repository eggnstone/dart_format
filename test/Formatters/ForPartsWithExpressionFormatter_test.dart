import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/ForPartsWithExpressionFormatter.dart';

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
            inputNodeCreator: AstCreator.createForLoopPartsInFunction,
            inputLeading: 'void f(){for(',
            inputMiddle: ';;i++,j--',
            inputTrailing: ');}',
            name: 'ForPartsWithExpression ;;i++,j--',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<PostfixExpression>(15, 'i++'),
                TestVisitor<PostfixExpression>(19, 'j--')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createForLoopPartsInFunction,
            inputLeading: 'void f(){for(',
            inputMiddle: 'false; true; i++',
            inputTrailing: ');}',
            name: 'ForPartsWithExpression false; true; i++ (normal spacing)',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<BooleanLiteral>(13, 'false'),
                TestVisitor<BooleanLiteral>(19, ' true'),
                TestVisitor<PostfixExpression>(25, ' i++')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('false; true; i++')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createForLoopPartsInFunction,
            inputLeading: 'void f(){for(',
            inputMiddle: 'false;true;i++',
            inputTrailing: ');}',
            name: 'ForPartsWithExpression false; true; i++ (too little spacing)',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<BooleanLiteral>(13, 'false'),
                TestVisitor<BooleanLiteral>(19, 'true'),
                TestVisitor<PostfixExpression>(24, 'i++')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('false;true;i++')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createForLoopPartsInFunction,
            inputLeading: 'void f(){for(',
            inputMiddle: '  false  ;  true  ;  i++',
            inputTrailing: ');}',
            name: 'ForPartsWithExpression false; true; i++ (too much spacing)',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<BooleanLiteral>(13, '  false'),
                TestVisitor<BooleanLiteral>(23, '  true'),
                TestVisitor<PostfixExpression>(32, '  i++')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('  false;  true;  i++')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'ForPartsWithExpressionFormatter', ForPartsWithExpressionFormatter.new, StackTrace.current);
}
