import '../../TestTools/AstCreator.dart';
import '../../TestTools/TestConfig.dart';
import '../../TestTools/TestGroupConfig.dart';
import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final TestGroupConfig testGroupConfig = TestGroupConfig(
        inputNodeCreator: AstCreator.createStatementInFunction,
        inputLeading: 'void f(){',
        inputMiddle: 'if (true){}\n',
        inputTrailing: '}',
        name: 'IfStatement / empty Block',
        testConfigs: <TestConfig>[
            TestConfig.none(null, ''),
            TestConfig('if (true) \n{\n}\n', '')
        ]
    );

    TestTools.runTestGroup(testGroupConfig, name: 'FormatVisitor');
}
