import 'package:dart_format/src/Formatters/DeclarationFormatters/EnumDeclarationFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestConfig.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestAstVisitor.dart';
import '../TestTools/Visitors/TestEnumConstantDeclarationVisitor.dart';

void main()
{
    TestTools.init();

    // TODO: move tests with different existing indentations to a separate test group.

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createDeclaration,
            inputMiddle: 'enum E{x,y}',
            name: 'EnumDeclaration in 1 line',
            astVisitors: <TestAstVisitor>[
                TestEnumConstantDeclarationVisitor(7, 'x'),
                TestEnumConstantDeclarationVisitor(9, 'y')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('enum E\n{\n    x,y\n}\n')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createDeclaration,
            inputMiddle: 'enum E{x,\ny}',
            name: 'EnumDeclaration in 2 lines',
            astVisitors: <TestAstVisitor>[
                TestEnumConstantDeclarationVisitor(7, 'x'),
                TestEnumConstantDeclarationVisitor(10, 'y')
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
            astVisitors: <TestAstVisitor>[
                TestEnumConstantDeclarationVisitor(8, 'x'),
                TestEnumConstantDeclarationVisitor(11, 'y')
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
            astVisitors: <TestAstVisitor>[
                TestEnumConstantDeclarationVisitor(8, 'x'),
                TestEnumConstantDeclarationVisitor(11, 'y'),
                TestEnumConstantDeclarationVisitor(14, 'z')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none('enum E{\nx,\ny,\nz}'),
                TestConfig('enum E\n{\n    x,\n    y,\n    z\n}\n')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'EnumDeclarationFormatter', EnumDeclarationFormatter.new, StackTrace.current);
}
