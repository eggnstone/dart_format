import '../../TestTools/AstCreator.dart';
import '../../TestTools/TestConfig.dart';
import '../../TestTools/TestGroupConfig.dart';
import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    const String leading = 'class C{';
    const String middle = 'void m()\n{\n;\n}';
    const String trailing = '}';
    final TestGroupConfig testGroupConfig = TestGroupConfig(
        inputNodeCreator: AstCreator.createClassMember,
        inputLeading: leading,
        inputMiddle: middle,
        inputTrailing: trailing,
        name: 'MethodDeclaration / EmptyStatement',
        testConfigs: <TestConfig>[
            TestConfig.none(null, ''),
            TestConfig('void m()\n{\n    ;\n}\n', '')
        ]
    );

    TestTools.runTestGroup(testGroupConfig, name: 'FormatVisitor');
}
