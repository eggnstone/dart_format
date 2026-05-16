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
                // ignore: avoid_redundant_argument_values
                TestConfig.custom('Custom2', Config.all(fixSpaces: true, removeTrailingCommas: false), "assert(true, 'message',);\n"),
                TestConfig("assert(true, 'message');\n")
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: "assert    (    true    ,    'message'    ,    )    ;",
            inputTrailing: '}',
            name: "AssertStatement assert(true, 'message',);",
            astVisitors: <TestVisitor<void>>[
                TestVisitor<BooleanLiteral>(24, 'true'),
                TestVisitor<SimpleStringLiteral>(37, "'message'")
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig.custom('Custom1', Config.all(fixSpaces: false), "assert    (    true    ,    'message'        )    ;\n"),
                // ignore: avoid_redundant_argument_values
                TestConfig.custom('Custom2', Config.all(fixSpaces: true, removeTrailingCommas: false), "assert(true, 'message',);\n"),
                TestConfig("assert(true, 'message');\n")
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: "assert(true == true,'message',);",
            inputTrailing: '}',
            name: 'AssertStatement with BinaryExpression condition and trailing comma',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<BinaryExpression>(16, 'true == true'),
                TestVisitor<SimpleStringLiteral>(29, "'message'")
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig("assert(true == true, 'message');\n")
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: "assert(c,\n    'a'\n    'b'\n    );",
            inputTrailing: '}',
            name: 'AssertStatement with multi-line adjacent-string message indents the message past assert(',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(16, 'c'),
                TestVisitor<AdjacentStrings>(23, "'a'\n    'b'")
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig(
                    'assert(c,\n'
                    "    'a'\n"
                    "    'b'\n"
                    ');\n'
                )
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'AssertStatementFormatter', AssertStatementFormatter.new, StackTrace.current);
}
