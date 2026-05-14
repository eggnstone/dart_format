import 'package:dart_format/src/Formatters/DottedNameFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestConfig.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createDottedNameInImportConfiguration,
            inputLeading: "import 'a.dart' if (",
            inputMiddle: 'a.b.c',
            inputTrailing: ") 'b.dart';",
            name: 'DottedName',
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('a.b.c')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'DottedNameFormatter', DottedNameFormatter.new, StackTrace.current);
}
