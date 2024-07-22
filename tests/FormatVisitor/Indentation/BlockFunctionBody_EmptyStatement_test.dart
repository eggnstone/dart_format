import '../../TestTools/AstCreator.dart';
import '../../TestTools/TestConfig.dart';
import '../../TestTools/TestGroupConfig.dart';
import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final TestGroupConfig testGroupConfig = TestGroupConfig(
        inputNodeCreator: AstCreator.createFunctionBodyInFunction,
        inputLeading: 'void f()',
        inputMiddle: '{\n;\n}',
        name: 'BlockFunctionBody / EmptyStatement',
        testConfigs: <TestConfig>[
            TestConfig.none(),
            TestConfig('\n{\n    ;\n}\n')
        ]
    );

    TestTools.runTestGroup(testGroupConfig, name: 'FormatVisitor');
}
