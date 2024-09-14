import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/ForPartsWithDeclarationsFormatter.dart';

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
            inputMiddle: 'int i=0,j=0;;i++,j--',
            inputTrailing: ');}',
            name: 'ForPartsWithDeclarations: int i=0,j=0;;i++,j--',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<VariableDeclarationList>(13, 'int i=0,j=0'),
                TestVisitor<PostfixExpression>(26, 'i++'),
                TestVisitor<PostfixExpression>(30, 'j--')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('int i=0,j=0;; i++,j--')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createForLoopPartsInFunction,
            inputLeading: 'void f(){for(',
            inputMiddle: 'int i = 0; i < 10; i++',
            inputTrailing: ');}',
            name: 'ForPartsWithDeclarations: int i = 0; i < 10; i++ (normal spacing)',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<VariableDeclarationList>(13, 'int i = 0'),
                TestVisitor<BinaryExpression>(24, 'i < 10'),
                TestVisitor<PostfixExpression>(32, 'i++')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createForLoopPartsInFunction,
            inputLeading: 'void f(){for(',
            inputMiddle: 'int i=0;i<10;i++',
            inputTrailing: ');}',
            name: 'ForPartsWithDeclarations: int i = 0; i < 10; i++ (too little spacing)',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<VariableDeclarationList>(13, 'int i=0'),
                TestVisitor<BinaryExpression>(21, 'i<10'),
                TestVisitor<PostfixExpression>(26, 'i++')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('int i=0; i<10; i++')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createForLoopPartsInFunction,
            inputLeading: 'void f(){for(',
            inputMiddle: 'int  i  =  0  ;  i  <  10  ;  i++',
            inputTrailing: ');}',
            name: 'ForPartsWithDeclarations: int i = 0; i < 10; i++ (too much spacing)',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<VariableDeclarationList>(13, 'int  i  =  0'),
                TestVisitor<BinaryExpression>(30, 'i  <  10'),
                TestVisitor<PostfixExpression>(43, 'i++')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('int  i  =  0; i  <  10; i++')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'ForPartsWithDeclarationsFormatter', ForPartsWithDeclarationsFormatter.new, StackTrace.current);
}
