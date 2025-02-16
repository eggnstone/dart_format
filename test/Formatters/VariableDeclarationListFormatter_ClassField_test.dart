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
            inputNodeCreator: AstCreator.createVariableDeclarationListInClass,
            inputLeading: 'class C{',
            inputMiddle: 'late final int i = 0',
            inputTrailing: ';}',
            name: 'VariableDeclarationList late final int i = 0;',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(19, 'int'),
                TestVisitor<VariableDeclaration>(23, 'i = 0')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createVariableDeclarationListInClass,
            inputLeading: 'class C{',
            inputMiddle: 'late\nint i=0',
            inputTrailing: ';}',
            name: r'VariableDeclarationList late\nint i=0',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(13, 'int'),
                TestVisitor<VariableDeclaration>(17, 'i=0')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('late\n    int i=0')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createVariableDeclarationListInClass,
            inputLeading: 'class C{',
            inputMiddle: 'int\ni=0',
            inputTrailing: ';}',
            name: r'VariableDeclarationList int\n i=0',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(8, 'int'),
                TestVisitor<VariableDeclaration>(12, 'i=0')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('int\n    i=0')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createVariableDeclarationListInClass,
            inputLeading: 'class C{',
            inputMiddle: 'int i=\n0',
            inputTrailing: ';}',
            name: r'VariableDeclarationList int i=\n0',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(8, 'int'),
                TestVisitor<VariableDeclaration>(12, 'i=\n0')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('int i=\n0')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'VariableDeclarationListFormatter', VariableDeclarationListFormatter.new, StackTrace.current);
}
