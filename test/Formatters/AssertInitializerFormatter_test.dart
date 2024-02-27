import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/AssertInitializerFormatter.dart';

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
            inputNodeCreator: AstCreator.createConstructorInitializer,
            inputLeading: 'class C{C():',
            inputMiddle: 'assert(true,)',
            inputTrailing: ';}',
            name: 'AssertInitializer',
            astVisitors: <TestVisitor<AstNode>>[
                TestVisitor<BooleanLiteral>(19, 'true')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('assert(true)')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createConstructorInitializer,
            inputLeading: 'class C{C():',
            inputMiddle: "assert(true,'message',)",
            inputTrailing: ';}',
            name: 'AssertInitializer with message',
            astVisitors: <TestVisitor<AstNode>>[
                TestVisitor<BooleanLiteral>(19, 'true'),
                TestVisitor<SimpleStringLiteral>(24, "'message'")
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig("assert(true,'message')")
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'AssertInitializerFormatter', AssertInitializerFormatter.new, StackTrace.current);
}
