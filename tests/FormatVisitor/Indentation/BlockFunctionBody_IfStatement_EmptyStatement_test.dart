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
        inputMiddle: '{\nif (true)\n;\n}',
        name: 'BlockFunctionBody / IfStatement / EmptyStatement',
        testConfigs: <TestConfig>[
            TestConfig.none(),
            TestConfig('\n{\n    if (true)\n        ;\n}\n')
        ]
    );

    TestTools.runTestGroup(testGroupConfig, name: 'FormatVisitor');
}
