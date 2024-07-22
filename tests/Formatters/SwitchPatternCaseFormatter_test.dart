import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/SwitchPatternCaseFormatter.dart';

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
            inputNodeCreator: AstCreator.createSwitchStatementMemberInFunction,
            inputLeading: 'void f(){switch(i){',
            inputMiddle: 'case 0:\n;\n;',
            inputTrailing: '}}',
            name: 'SwitchPatternCase',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<GuardedPattern>(24, '0'),
                TestVisitor<EmptyStatement>(27, ';'),
                TestVisitor<EmptyStatement>(29, ';')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('case 0:\n    ;\n    ;')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'SwitchPatternCaseFormatter', SwitchPatternCaseFormatter.new, StackTrace.current);
}
