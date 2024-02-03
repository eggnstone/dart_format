import '../../TestTools/AstCreator.dart';
import '../../TestTools/TestConfig.dart';
import '../../TestTools/TestGroupConfig.dart';
import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    const String text = 'class C\n{\nvoid m()\n{\n;\n}\n}\n';
    final TestGroupConfig testGroupConfig = TestGroupConfig(
        inputNodeCreator: AstCreator.createDeclaration,
        inputMiddle: text,
        name: 'ClassDeclaration / VoidMethod / EmptyStatement',
        testConfigs: <TestConfig>[
            TestConfig.none(),
            TestConfig('class C\n{\n    void m()\n    {\n        ;\n    }\n}\n')
        ]
    );

    TestTools.runTestGroup(testGroupConfig, name: 'FormatVisitor');
}
