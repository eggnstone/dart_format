import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/SetOrMapLiteralFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestConfig.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestVisitor.dart';

SetOrMapLiteral _createSetOrMapLiteral(String s)
=> ((((AstCreator.createCompilationUnit(s)
    .declarations[0] as FunctionDeclaration)
    .functionExpression.body as BlockFunctionBody)
    .block
    .statements[0] as ExpressionStatement)
    .expression as AssignmentExpression)
    .rightHandSide as SetOrMapLiteral;

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: _createSetOrMapLiteral,
            inputLeading: 'void f(){a=',
            inputMiddle: '{b}',
            inputTrailing: ';}',
            name: 'SetOrMapLiteral with no line breaks',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(12, 'b')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('{b}')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: _createSetOrMapLiteral,
            inputLeading: 'void f(){a=',
            inputMiddle: '\n{\nb\n}',
            inputTrailing: '\n;}',
            name: 'SetOrMapLiteral with all line breaks',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(14, 'b')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('\n{\n    b\n}')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: _createSetOrMapLiteral,
            inputLeading: 'void f(){a=\n',
            inputMiddle: '{b}',
            inputTrailing: ';}',
            name: r'SetOrMapLiteral \n{',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(13, 'b')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('{b}')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: _createSetOrMapLiteral,
            inputLeading: 'void f(){a=',
            inputMiddle: '{\nb}',
            inputTrailing: ';}',
            name: r'SetOrMapLiteral {\n',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(13, 'b')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('\n{\n    b\n}')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: _createSetOrMapLiteral,
            inputLeading: 'void f(){a=',
            inputMiddle: '{b\n}',
            inputTrailing: ';}',
            name: r'SetOrMapLiteral \n}',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(12, 'b')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('\n{\n    b\n}')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: _createSetOrMapLiteral,
            inputLeading: 'void f(){a=',
            inputMiddle: '{b}',
            inputTrailing: '\n;}',
            name: r'SetOrMapLiteral }\n',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(12, 'b')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('{b}')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'SetOrMapLiteralFormatter', SetOrMapLiteralFormatter.new, StackTrace.current);
}
