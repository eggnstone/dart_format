import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/VariableDeclarationListFormatter.dart';

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
            inputNodeCreator: AstCreator.createVariableDeclarationListInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'int a=0',
            inputTrailing: ';}',
            name: 'VariableDeclarationList with type and single variable',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(9, 'int'),
                TestVisitor<VariableDeclaration>(13, 'a=0')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('int a=0')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createVariableDeclarationListInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'var a=0,b=1',
            inputTrailing: ';}',
            name: 'VariableDeclarationList with var keyword and two variables',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<VariableDeclaration>(13, 'a=0'),
                TestVisitor<VariableDeclaration>(17, 'b=1')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('var a=0, b=1')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createVariableDeclarationListInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'late int a=0',
            inputTrailing: ';}',
            name: 'VariableDeclarationList with late keyword',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(14, 'int'),
                TestVisitor<VariableDeclaration>(18, 'a=0')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('late int a=0')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'VariableDeclarationListFormatter', VariableDeclarationListFormatter.new, StackTrace.current);
}
