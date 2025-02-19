import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/dart_format.dart';
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
            inputMiddle: 'assert(true)',
            inputTrailing: ';}',
            name: 'AssertInitializer assert(true)',
            astVisitors: <TestVisitor<void>>[
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
            inputMiddle: 'assert(true,)',
            inputTrailing: ';}',
            name: 'AssertInitializer assert(true,)',
            astVisitors: <TestVisitor<void>>[
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
            inputMiddle: "assert(true,'message')",
            inputTrailing: ';}',
            name: "AssertInitializer assert(true, 'message')",
            astVisitors: <TestVisitor<void>>[
                TestVisitor<BooleanLiteral>(19, 'true'),
                TestVisitor<SimpleStringLiteral>(24, "'message'")
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig("assert(true,'message')")
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createConstructorInitializer,
            inputLeading: 'class C{C():',
            inputMiddle: "assert(true,'message',)",
            inputTrailing: ';}',
            name: "AssertInitializer assert(true, 'message',) (too little spacing)",
            astVisitors: <TestVisitor<void>>[
                TestVisitor<BooleanLiteral>(19, 'true'),
                TestVisitor<SimpleStringLiteral>(24, "'message'")
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                // ignore: avoid_redundant_argument_values
                TestConfig.custom('Custom1', Config.all(fixSpaces: false), "assert(true,'message')"),
                TestConfig.custom('Custom2', Config.all(fixSpaces: true, removeTrailingCommas: false), "assert(true,'message',)"),
                TestConfig("assert(true,'message')")
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createConstructorInitializer,
            inputLeading: 'class C{C():',
            inputMiddle: "assert  (  true  ,  'message'  ,  )",
            inputTrailing: ';}',
            name: "AssertInitializer assert(true, 'message',) (too much spacing)", // TODO: too little spacing
            astVisitors: <TestVisitor<void>>[
                TestVisitor<BooleanLiteral>(21, '  true'),
                TestVisitor<SimpleStringLiteral>(30, "  'message'")
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                // ignore: avoid_redundant_argument_values
                TestConfig.custom('Custom1', Config.all(fixSpaces: false), "assert  (  true  ,  'message'    )"),
                TestConfig.custom('Custom2', Config.all(fixSpaces: true, removeTrailingCommas: false), "assert(  true,  'message',)"),
                TestConfig("assert(  true,  'message')")
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'AssertInitializerFormatter', AssertInitializerFormatter.new, StackTrace.current);
}
