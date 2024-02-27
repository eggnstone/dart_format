import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/AssertStatementFormatter.dart';

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
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'assert(true,);',
            inputTrailing: '}',
            name: 'AssertStatement',
            astVisitors: <TestVisitor<AstNode>>[
                TestVisitor<BooleanLiteral>(16, 'true')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('assert(true);\n')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: "assert(true,'message',);",
            inputTrailing: '}',
            name: 'AssertStatement with message',
            astVisitors: <TestVisitor<AstNode>>[
                TestVisitor<BooleanLiteral>(16, 'true'),
                TestVisitor<SimpleStringLiteral>(21, "'message'")
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig("assert(true,'message');\n")
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'AssertStatementFormatter', AssertStatementFormatter.new, StackTrace.current);
}
