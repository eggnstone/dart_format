import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/BreakStatementFormatter.dart';

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
            inputNodeCreator: AstCreator.createStatementInWhileInFunction,
            inputLeading: 'void f(){while(true)',
            inputMiddle: 'break;',
            inputTrailing: '}',
            name: 'BreakStatement',
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('break;\n')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInWhileInFunction,
            inputLeading: 'void f(){while(true)',
            inputMiddle: 'break outer;',
            inputTrailing: '}',
            name: 'BreakStatement with label',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(26, 'outer')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('break outer;\n')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'BreakStatementFormatter', BreakStatementFormatter.new, StackTrace.current);
}
