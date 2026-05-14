import 'package:dart_format/src/Formatters/InterpolationStringFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestConfig.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createInterpolationStringInVariable,
            inputLeading: 'void f(int n){var s = ',
            inputMiddle: "'a",
            inputTrailing: r"${n}b';}",
            name: 'InterpolationString leading',
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig("'a")
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'InterpolationStringFormatter', InterpolationStringFormatter.new, StackTrace.current);
}
