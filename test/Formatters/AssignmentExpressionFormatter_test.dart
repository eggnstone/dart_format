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
                TestVisitor<SetOrMapLiteral>(11, '{b}')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('a = {b}')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.x4,
            inputLeading: 'void f(){File file;  ',
            inputMiddle: 'file  =  File  (  )',
            inputTrailing: '  ;}',
            name: 'TODO 1',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(21, 'file'),
                TestVisitor<MethodInvocation>(30, 'File  (  )')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('file = File  (  )')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.x4,
            inputLeading: 'void f(){C c;  ',
            inputMiddle: 'c  =  C  .  c  (  )',
            inputTrailing: ';}',
            name: 'TODO 2',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(15, 'c'),
                TestVisitor<MethodInvocation>(21, 'C  .  c  (  )')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('c = C  .  c  (  )')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'AssignmentExpressionFormatter', AssignmentExpressionFormatter.new, StackTrace.current);
}
