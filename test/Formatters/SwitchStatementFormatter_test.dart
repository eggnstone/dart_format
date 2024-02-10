import 'package:dart_format/src/Formatters/SwitchStatementFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestConfig.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestAstVisitor.dart';
import '../TestTools/Visitors/TestSimpleIdentifierVisitor.dart';
import '../TestTools/Visitors/TestSwitchPatternCaseVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'switch(i){case 0:;}',
            inputTrailing: '}',
            name: 'SwitchStatement',
            astVisitors: <TestAstVisitor>[
                TestSimpleIdentifierVisitor(16, 'i'),
                TestSwitchPatternCaseVisitor(19, 'case 0:;')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('switch(i)\n{\n    case 0:;\n}\n')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'SwitchStatementFormatter', SwitchStatementFormatter.new, StackTrace.current);
}
