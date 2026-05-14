import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/YieldStatementFormatter.dart';

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
            inputNodeCreator: AstCreator.createYieldStatementInFunction,
            inputLeading: 'Iterable<int> f() sync*{',
            inputMiddle: 'yield 1;',
            inputTrailing: '}',
            name: 'YieldStatement',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<IntegerLiteral>(30, '1')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('yield 1;\n')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createYieldStatementInFunction,
            inputLeading: 'Stream<int> f() async*{',
            inputMiddle: 'yield* s;',
            inputTrailing: '}',
            name: 'YieldStatement with star',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(30, 's')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('yield* s;\n')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'YieldStatementFormatter', YieldStatementFormatter.new, StackTrace.current);
}
