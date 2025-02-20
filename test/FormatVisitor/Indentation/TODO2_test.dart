import '../../TestTools/AstCreator.dart';
import '../../TestTools/TestConfig.dart';
import '../../TestTools/TestGroupConfig.dart';
import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    const String text = 'class C{void m()=>a;/*Comment*/void d(){}}';
    final TestGroupConfig testGroupConfig = TestGroupConfig(
        inputNodeCreator: AstCreator.createDeclaration,
        inputMiddle: text,
        name: 'TODO2',
        testConfigs: <TestConfig>[
            TestConfig.none(),
            TestConfig('class C\n{\n    void m() => a;\n    /*Comment*/void d() \n    {\n    }\n}\n')
            //TODO: TestConfig('class C\n{\n    void m() => a;\n    /*Comment*/void d()\n    {\n    }\n}\n')
        ]
    );

    TestTools.runTestGroup(testGroupConfig, name: 'FormatVisitor');
}
