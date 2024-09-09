import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/SwitchExpressionFormatter.dart';

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
            inputNodeCreator: AstCreator.createSwitchExpressionInReturnStatementExpressionInFunction,
            inputLeading: 'int f(){return ',
            inputMiddle: 'switch(0){0=>0}',
            inputTrailing: ';}',
            name: 'SwitchPatternCase',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<IntegerLiteral>(22, '0'),
                TestVisitor<SwitchExpressionCase>(25, '0=>0')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('switch (0)\n{\n    0=>0\n}')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'SwitchExpressionFormatter', SwitchExpressionFormatter.new, StackTrace.current);
}
