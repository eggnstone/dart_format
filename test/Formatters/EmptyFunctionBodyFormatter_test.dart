import 'package:dart_format/src/Formatters/EmptyFunctionBodyFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestConfig.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createEmptyFunctionBodyInMethodInClass,
            inputLeading: 'abstract class C{void f()',
            inputMiddle: ';',
            inputTrailing: '}',
            name: 'EmptyFunctionBody',
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig(';\n')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'EmptyFunctionBodyFormatter', EmptyFunctionBodyFormatter.new, StackTrace.current);
}
