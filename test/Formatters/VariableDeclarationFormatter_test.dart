import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/VariableDeclarationFormatter.dart';

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
            inputNodeCreator: AstCreator.createVariableDeclarationInTopLevelVariableDeclaration,
            inputLeading: 'int ',
            inputMiddle: 'i=f.a.b',
            inputTrailing: ';',
            name: 'VariableDeclaration i=f.a.b',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<PropertyAccess>(6, 'f.a.b')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createVariableDeclarationInTopLevelVariableDeclaration,
            inputLeading: 'int ',
            inputMiddle: 'i\n=f.a.b',
            inputTrailing: ';',
            name: r'VariableDeclaration i\n=f.a.b',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<PropertyAccess>(7, 'f.a.b')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('i\n    =f.a.b')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createVariableDeclarationInTopLevelVariableDeclaration,
            inputLeading: 'int ',
            inputMiddle: 'i=\nf.a.b',
            inputTrailing: ';',
            name: r'VariableDeclaration i=\nf.a.b',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<PropertyAccess>(7, 'f.a.b')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('i=\n    f.a.b')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createVariableDeclarationInTopLevelVariableDeclaration,
            inputLeading: 'int ',
            inputMiddle: 'i\n=\nf.a.b',
            inputTrailing: ';',
            name: r'VariableDeclaration i\n=\nf.a.b',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<PropertyAccess>(8, 'f.a.b')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('i\n    =\n    f.a.b')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'VariableDeclarationFormatter', VariableDeclarationFormatter.new, StackTrace.current);
}
