import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/ContinueStatementFormatter.dart';

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
            inputMiddle: 'continue;',
            inputTrailing: '}',
            name: 'ContinueStatement',
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('continue;\n')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInWhileInFunction,
            inputLeading: 'void f(){while(true)',
            inputMiddle: 'continue outer;',
            inputTrailing: '}',
            name: 'ContinueStatement with label',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(29, 'outer')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('continue outer;\n')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'ContinueStatementFormatter', ContinueStatementFormatter.new, StackTrace.current);
}
