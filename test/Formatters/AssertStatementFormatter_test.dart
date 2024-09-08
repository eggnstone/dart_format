import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/dart_format.dart';
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
            inputMiddle: 'assert(true);',
            inputTrailing: '}',
            name: 'AssertStatement assert(true);',
            astVisitors: <TestVisitor<void>>[
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
            inputMiddle: 'assert(true,);',
            inputTrailing: '}',
            name: 'AssertStatement assert(true,);',
            astVisitors: <TestVisitor<void>>[
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
            inputMiddle: "assert(true,'message');",
            inputTrailing: '}',
            name: "AssertStatement assert(true, 'message');",
            astVisitors: <TestVisitor<void>>[
                TestVisitor<BooleanLiteral>(16, 'true'),
                TestVisitor<SimpleStringLiteral>(21, "'message'")
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig("assert(true,'message');\n")
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: "assert(true,'message',);",
            inputTrailing: '}',
            name: "AssertStatement assert(true, 'message',); (too little spacing)",
            astVisitors: <TestVisitor<void>>[
                TestVisitor<BooleanLiteral>(16, 'true'),
                TestVisitor<SimpleStringLiteral>(21, "'message'")
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig.custom('Custom1', Config.all(fixSpaces: false), "assert(true,'message');\n"),
                TestConfig.custom('Custom2', Config.all(removeTrailingCommas: false), "assert(true,'message',);\n"),
                TestConfig("assert(true,'message');\n")
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: "assert    (    true    ,    'message'    ,    )    ;",
            inputTrailing: '}',
            name: "AssertStatement assert(true, 'message',); (too much spacing)",
            astVisitors: <TestVisitor<void>>[
                TestVisitor<BooleanLiteral>(20, '    true'),
                TestVisitor<SimpleStringLiteral>(33, "    'message'")
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig.custom('Custom1', Config.all(fixSpaces: false), "assert    (    true    ,    'message'        )    ;\n"),
                TestConfig.custom('Custom2', Config.all(removeTrailingCommas: false), "assert(    true,    'message',);\n"),
                TestConfig("assert(    true,    'message');\n")
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'AssertStatementFormatter', AssertStatementFormatter.new, StackTrace.current);
}
