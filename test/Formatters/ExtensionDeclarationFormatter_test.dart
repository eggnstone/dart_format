import 'package:dart_format/src/Formatters/DeclarationFormatters/ExtensionDeclarationFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestConfig.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestAstVisitor.dart';
import '../TestTools/Visitors/TestMethodDeclarationVisitor.dart';
import '../TestTools/Visitors/TestNamedTypeVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createDeclaration,
            inputMiddle: 'extension E on C{void m(){}}',
            name: 'ExtensionDeclaration',
            astVisitors: <TestAstVisitor>[
                TestNamedTypeVisitor(15, 'C'),
                TestMethodDeclarationVisitor(17, 'void m(){}')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('extension E on C\n{\n    void m(){}\n}\n')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'ExtensionDeclarationFormatter', ExtensionDeclarationFormatter.new, StackTrace.current);
}
