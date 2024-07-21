import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/SetOrMapLiteralFormatter.dart';

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
            inputNodeCreator: AstCreator.createRightHandSideInAssignmentExpressionInFunction,
            inputLeading: 'void f(){a=',
            inputMiddle: '{b}',
            inputTrailing: ';}',
            name: 'SetOrMapLiteral breakSetOrMapLiterals=false',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(12, 'b')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('{b}')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createRightHandSideInAssignmentExpressionInFunction,
            inputLeading: 'void f(){a=',
            inputMiddle: '{b}',
            inputTrailing: ';}',
            name: 'SetOrMapLiteral breakSetOrMapLiterals=true',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(12, 'b')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig.breakSetOrMapLiterals('\n{\n    b\n}')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'SetOrMapLiteralFormatter', SetOrMapLiteralFormatter.new, StackTrace.current);
}
