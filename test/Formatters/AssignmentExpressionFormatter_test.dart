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
            name: 'AssertStatement with map literal',
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
            inputNodeCreator: AstCreator.createAssignmentExpressionInFunction,
            inputLeading: 'void f(File file){  ',
            inputMiddle: 'file  =  File  (  )',
            inputTrailing: '  ;}',
            name: 'AssertStatement without target',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(20, 'file'),
                TestVisitor<MethodInvocation>(29, 'File  (  )')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('file = File  (  )')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createAssignmentExpressionInFunction,
            inputLeading: 'void f(C c){  ',
            inputMiddle: 'c  =  C  .  c  (  )',
            inputTrailing: ';}',
            name: 'AssertStatement with MethodInvocation with target',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(14, 'c'),
                TestVisitor<MethodInvocation>(20, 'C  .  c  (  )')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('c = C  .  c  (  )')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'AssignmentExpressionFormatter', AssignmentExpressionFormatter.new, StackTrace.current);
}
