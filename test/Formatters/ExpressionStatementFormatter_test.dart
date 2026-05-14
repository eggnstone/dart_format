import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/ExpressionStatementFormatter.dart';

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
            inputNodeCreator: AstCreator.createExpressionStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'a;',
            inputTrailing: '}',
            name: 'ExpressionStatement',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(9, 'a')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('a;\n')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'ExpressionStatementFormatter', ExpressionStatementFormatter.new, StackTrace.current);
}
