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
            inputMiddle: 'enum E implements F{x}',
            name: 'EnumDeclaration: enum E implements F{x}',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<ImplementsClause>(7, 'implements F'),
                TestVisitor<EnumConstantDeclaration>(20, 'x')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig(
                    'enum E implements F\n'
                    '{\n'
                    '    x\n'
                    '}\n'
                )
            ]
        ), 
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
                TestConfig(
                    'enum E\n'
                    '{\n'
                    '    x,y\n'
                    '}\n'
                )
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
                TestConfig(
                    'enum E\n'
                    '{\n'
                    '    x,y/**/\n'
                    '}\n'
                )
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
                TestConfig(
                    'enum E\n'
                    '{\n'
                    '    x,y;\n'
                    '}\n'
                )
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
                TestConfig(
                    'enum E\n'
                    '{\n'
                    '    x,y;\n'
                    '    void m();\n'
                    '}\n'
                )
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
                TestConfig(
                    'enum E\n'
                    '{\n'
                    '    x,\n'
                    '    y\n'
                    '}\n'
                )
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
                TestConfig.none(),
                TestConfig(
                    'enum E\n'
                    '{\n'
                    '    x,\n'
                    '    y\n'
                    '}\n'
                )
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
                TestConfig.none(),
                TestConfig(
                    'enum E\n'
                    '{\n'
                    '    x,\n'
                    '    y,\n'
                    '    z\n'
                    '}\n'
                )
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createDeclaration,
            inputMiddle: 'enum E<T>{x}',
            name: 'EnumDeclaration: enum E<T>{x}',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<TypeParameterList>(6, '<T>'),
                TestVisitor<EnumConstantDeclaration>(10, 'x')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig(
                    'enum E<T>\n'
                    '{\n'
                    '    x\n'
                    '}\n'
                )
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createDeclaration,
            inputMiddle: 'enum E with M{x}',
            name: 'EnumDeclaration: enum E with M{x}',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<WithClause>(7, 'with M'),
                TestVisitor<EnumConstantDeclaration>(14, 'x')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig(
                    'enum E with M\n'
                    '{\n'
                    '    x\n'
                    '}\n'
                )
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createDeclaration,
            inputMiddle: 'enum E<T> with M implements F{x}',
            name: 'EnumDeclaration: enum E<T> with M implements F{x}',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<TypeParameterList>(6, '<T>'),
                TestVisitor<WithClause>(10, 'with M'),
                TestVisitor<ImplementsClause>(17, 'implements F'),
                TestVisitor<EnumConstantDeclaration>(30, 'x')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig(
                    'enum E<T> with M implements F\n'
                    '{\n'
                    '    x\n'
                    '}\n'
                )
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createDeclarationWithAugmentations,
            inputMiddle: 'augment enum E{x}',
            name: 'EnumDeclaration: augment enum E{x}',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<EnumConstantDeclaration>(15, 'x')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig(
                    'augment enum E\n'
                    '{\n'
                    '    x\n'
                    '}\n'
                )
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'EnumDeclarationFormatter', EnumDeclarationFormatter.new, StackTrace.current);
}
