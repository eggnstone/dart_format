import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/DoStatementFormatter.dart';

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
            inputNodeCreator: AstCreator.createDoStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'do{a;}while(true);',
            inputTrailing: '}',
            name: 'DoStatement',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<Block>(11, '{a;}'),
                TestVisitor<BooleanLiteral>(21, 'true')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('do {a;} while (true);\n')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'DoStatementFormatter', DoStatementFormatter.new, StackTrace.current);
}
