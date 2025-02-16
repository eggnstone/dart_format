import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/ReturnStatementFormatter.dart';

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
            inputNodeCreator: AstCreator.createReturnStatementInFunction,
            inputLeading: 'int f(){',
            inputMiddle: 'return  0  ;',
            inputTrailing: '}',
            name: 'RecordLiteral',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<IntegerLiteral>(16, '0')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('return 0;\n')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'ReturnStatementFormatter', ReturnStatementFormatter.new, StackTrace.current);
}
