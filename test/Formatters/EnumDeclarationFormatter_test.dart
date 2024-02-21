import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/EnumDeclarationFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestConfig.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestVisitor.dart';

void main()
{
    TestTools.init();

    // TODO: move tests with different existing indentations to a separate test group.

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createDeclaration,
            inputMiddle: 'enum E{x,y,}',
            name: 'EnumDeclaration in 1 line with trailing comma',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<EnumConstantDeclaration>(7, 'x'),
                TestVisitor<EnumConstantDeclaration>(9, 'y')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('enum E\n{\n    x,y\n}\n')
            ]
        ), 
        TestGroupConfig(
            inputNodeCreator: AstCreator.createDeclaration,
            inputMiddle: 'enum E{x,y,/**/}',
            name: 'EnumDeclaration in 1 line with trailing comma and comment',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<EnumConstantDeclaration>(7, 'x'),
                TestVisitor<EnumConstantDeclaration>(9, 'y')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('enum E\n{\n    x,y/**/\n}\n')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createDeclaration,
            inputMiddle: 'enum E{x,y;}',
            name: 'EnumDeclaration in 1 line with trailing semicolon',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<EnumConstantDeclaration>(7, 'x'),
                TestVisitor<EnumConstantDeclaration>(9, 'y')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('enum E\n{\n    x,y;\n}\n')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createDeclaration,
            inputMiddle: 'enum E{x,y;void m();}',
            name: 'EnumDeclaration in 1 line with trailing semicolon and method',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<EnumConstantDeclaration>(7, 'x'),
                TestVisitor<EnumConstantDeclaration>(9, 'y'),
                TestVisitor<MethodDeclaration>(11, 'void m();')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('enum E\n{\n    x,y;\n    void m();\n}\n')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createDeclaration,
            inputMiddle: 'enum E{x,\ny}',
            name: 'EnumDeclaration in 2 lines',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<EnumConstantDeclaration>(7, 'x'),
                TestVisitor<EnumConstantDeclaration>(10, 'y')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('enum E\n{\n    x,\n    y\n}\n')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createDeclaration,
            inputMiddle: 'enum E{\nx,\ny}',
            name: 'EnumDeclaration in 3 lines',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<EnumConstantDeclaration>(8, 'x'),
                TestVisitor<EnumConstantDeclaration>(11, 'y')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none('enum E{\nx,\ny}'),
                TestConfig('enum E\n{\n    x,\n    y\n}\n')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createDeclaration,
            inputMiddle: 'enum E{\nx,\ny,\nz}',
            name: 'EnumDeclaration in 4 lines',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<EnumConstantDeclaration>(8, 'x'),
                TestVisitor<EnumConstantDeclaration>(11, 'y'),
                TestVisitor<EnumConstantDeclaration>(14, 'z')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none('enum E{\nx,\ny,\nz}'),
                TestConfig('enum E\n{\n    x,\n    y,\n    z\n}\n')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'EnumDeclarationFormatter', EnumDeclarationFormatter.new, StackTrace.current);
}
