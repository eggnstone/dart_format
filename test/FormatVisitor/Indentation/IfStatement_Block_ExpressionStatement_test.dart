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
        inputMiddle: 'if (true)\n{\na;\nb;\n}\n',
        inputTrailing: '}',
        name: 'IfStatement / Block / ExpressionStatement',
        testConfigs: <TestConfig>[
            TestConfig.none(null, ''),
            TestConfig('if (true)\n{\n    a;\n    b;\n}\n', '')
        ]
    );

    TestTools.runTestGroup(testGroupConfig, name: 'FormatVisitor');
}
