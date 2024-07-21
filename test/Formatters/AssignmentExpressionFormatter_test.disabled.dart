/*
import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/AssignmentExpressionFormatter.dart';

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
            inputNodeCreator: AstCreator.createAssignmentExpressionInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'a={b}',
            inputTrailing: ';}',
            name: 'AssertStatement',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(9, 'a'),
                TestVisitor<SetOrMapLiteral>(11, '{b}'),
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig()
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'AssignmentExpressionFormatter', AssignmentExpressionFormatter.new, StackTrace.current);
}
*/
