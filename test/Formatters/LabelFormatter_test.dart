import 'package:dart_format/src/Formatters/LabelFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestConfig.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createLabelInLabeledStatement,
            inputLeading: 'void f(){',
            inputMiddle: 'outer :',
            inputTrailing: 'while(true){}}',
            name: 'Label',
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('outer:')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'LabelFormatter', LabelFormatter.new, StackTrace.current);
}
