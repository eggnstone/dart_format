import 'package:dart_format/src/Formatters/StringInterpolationFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createInitializerInTopLevelVariable,
            inputLeading: 'var s=',
            inputMiddle: r"'a$b'",
            inputTrailing: ';',
            name: 'StringInterpolation'
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'StringInterpolationFormatter', StringInterpolationFormatter.new, StackTrace.current);
}
