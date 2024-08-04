import '../../TestTools/AstCreator.dart';
import '../../TestTools/TestConfig.dart';
import '../../TestTools/TestGroupConfig.dart';
import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    //const String text = 'class C{void m(){}/*Comment*/}';
    const String text =
        'class C{}/*\n'
        '*//*\n'
        '*/';
    final TestGroupConfig testGroupConfig = TestGroupConfig(
        inputNodeCreator: AstCreator.createDeclaration,
        inputMiddle: text,
        name: 'TODO',
        testConfigs: <TestConfig>[
            TestConfig.none(),
            TestConfig('class C\n{\n}        /*\n*//*\n*/')
        //TestConfig('class C\n{\n    void m()\n    {\n    }\n/*Comment*/\n}\n')
        ]
    );

    TestTools.runTestGroup(testGroupConfig, name: 'FormatVisitor');
}
