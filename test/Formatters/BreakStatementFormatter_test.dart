import 'package:dart_format/src/Formatters/StatementFormatters/BreakStatementFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestConfig.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';

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
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'BreakStatementFormatter', BreakStatementFormatter.new, StackTrace.current);
}
