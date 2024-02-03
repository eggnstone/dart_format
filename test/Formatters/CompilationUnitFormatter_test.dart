import 'package:dart_format/src/Formatters/CompilationUnitFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestConfig.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestAstVisitor.dart';
import '../TestTools/Visitors/TestClassDeclarationVisitor.dart';
import '../TestTools/Visitors/TestImportDirectiveVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createCompilationUnit,
            inputMiddle: '/*Comment\nA*/',
            name: 'Lonely block comment',
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('/*Comment\nA*/\n')
            ]
        ),
        /*TestGroupConfig(
        inputNodeCreator: AstCreator.createCompilationUnit,
        inputMiddle: '/*Comment\n A*/',
        name: 'Lonely block comment / formatted'
        ),*/

        TestGroupConfig(
            inputNodeCreator: AstCreator.createCompilationUnit,
            inputMiddle: '/*Comment\nA*/class C{}',
            name: 'Block comment before class declaration',
            astVisitors: <TestAstVisitor>[TestClassDeclarationVisitor(0, '/*Comment\nA*/class C{}')],
            //astVisitors: <TestAstVisitor>[TestClassDeclarationVisitor(14, 'class C{}')],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('/*Comment\nA*/class C{}\n')
            ]
        ),
        /*TestGroupConfig(
        inputNodeCreator: AstCreator.createCompilationUnit,
        inputMiddle: '/*Comment\n A*/class C{}',
        name: 'Block comment before class declaration / formatted',
        astVisitors: <TestAstVisitor>[TestClassDeclarationVisitor(14, 'class C{}')]
        ),*/

        TestGroupConfig(
            inputNodeCreator: AstCreator.createCompilationUnit,
            inputMiddle: 'class C{}/*Comment\nA*/',
            name: 'Block comment after class declaration',
            astVisitors: <TestAstVisitor>[TestClassDeclarationVisitor(0, 'class C{}')],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('class C{}/*Comment\nA*/\n')
            ]
        ),
        /*TestGroupConfig(
        inputNodeCreator: AstCreator.createCompilationUnit,
        inputMiddle: 'class C{}/*Comment\n A*/',
        name: 'Block comment after class declaration / formatted',
        astVisitors: <TestAstVisitor>[TestClassDeclarationVisitor(0, 'class C{}')]
        ),*/

        /*TestGroupConfig(
        inputNodeCreator: AstCreator.createCompilationUnit,
        inputMiddle: 'class C{void m(){}/*Comment\nA*/}class D{}',
        name: 'Block comment after class declaration',
        astVisitors: <TestAstVisitor>[
        TestClassDeclarationVisitor(0, 'class C{}'),
        TestMethodDeclarationVisitor(8, 'void m(){}'),
        TestClassDeclarationVisitor(32, 'class D{}')
        ],
        testConfigs: <TestConfig>[
        TestConfig.none(),
        TestConfig('class C{}/*Comment\nA*/\n')
        ]
        ),*/

        TestGroupConfig(
            inputNodeCreator: AstCreator.createCompilationUnit,
            inputMiddle: '/**DocComment\nA*/',
            name: 'Lonely doc block comment',
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('/**DocComment\nA*/\n')
            ]
        ),
        /*TestGroupConfig(
        inputNodeCreator: AstCreator.createCompilationUnit,
        inputMiddle: '/**DocComment\n A*/',
        name: 'Lonely doc block comment / formatted'
        ),*/

        TestGroupConfig(
            inputNodeCreator: AstCreator.createCompilationUnit,
            inputMiddle: '/**DocComment\nA*/class C{}',
            name: 'Doc block comment before class declaration',
            astVisitors: <TestAstVisitor>[TestClassDeclarationVisitor(0, '/**DocComment\nA*/class C{}')],
            //astVisitors: <TestAstVisitor>[TestClassDeclarationVisitor(18, 'class C{}')],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('/**DocComment\nA*/class C{}\n')
            ]
        ),
        /*TestGroupConfig(
        inputNodeCreator: AstCreator.createCompilationUnit,
        inputMiddle: '/**DocComment\n A*/class C{}',
        name: 'Doc block comment before class declaration / formatted'',
        astVisitors: <TestAstVisitor>[TestClassDeclarationVisitor(18, 'class C{}')]
        ),*/

        TestGroupConfig(
            inputNodeCreator: AstCreator.createCompilationUnit,
            inputMiddle: 'class C{}/**DocComment\nA*/',
            name: 'Doc block comment after class declaration',
            astVisitors: <TestAstVisitor>[TestClassDeclarationVisitor(0, 'class C{}')],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('class C{}/**DocComment\nA*/\n')
            ]
        ),
        /*TestGroupConfig(
        inputNodeCreator: AstCreator.createCompilationUnit,
        inputMiddle: 'class C{}/**DocComment\n A*/',
        name: 'Doc block comment after class declaration / formatted',
        astVisitors: <TestAstVisitor>[TestClassDeclarationVisitor(0, 'class C{}')]
        ),*/

        TestGroupConfig(
            inputNodeCreator: AstCreator.createCompilationUnit,
            inputMiddle: 'class C{}',
            name: 'Class declaration',
            astVisitors: <TestAstVisitor>[TestClassDeclarationVisitor(0, 'class C{}')],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('class C{}\n')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createCompilationUnit,
            inputMiddle: "import'';",
            name: 'Import directive',
            astVisitors: <TestAstVisitor>[TestImportDirectiveVisitor(0, "import'';")],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig("import'';\n")
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'CompilationUnitFormatter', CompilationUnitFormatter.new, StackTrace.current);
}
