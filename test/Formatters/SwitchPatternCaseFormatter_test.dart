import 'package:dart_format/src/Formatters/SwitchPatternCaseFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestConfig.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestAstVisitor.dart';
import '../TestTools/Visitors/TestEmptyStatementVisitor.dart';
import '../TestTools/Visitors/TestGuardedPatternVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createSwitchStatementMemberInFunction,
            inputLeading: 'void f(){switch(i){',
            inputMiddle: 'case 0:\n;\n;',
            inputTrailing: '}}',
            name: 'SwitchPatternCase',
            astVisitors: <TestAstVisitor>[
                TestGuardedPatternVisitor(24, '0'),
                TestEmptyStatementVisitor(27, ';'),
                TestEmptyStatementVisitor(29, ';')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('case 0:\n    ;\n    ;')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'SwitchPatternCaseFormatter', SwitchPatternCaseFormatter.new, StackTrace.current);
}
