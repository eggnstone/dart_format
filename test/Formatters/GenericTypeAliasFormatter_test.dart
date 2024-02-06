import 'package:dart_format/src/Formatters/GenericTypeAliasFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestConfig.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestAstVisitor.dart';
import '../TestTools/Visitors/TestGenericFunctionTypeVisitor.dart';
import '../TestTools/Visitors/TestNamedTypeVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createDeclaration,
            inputMiddle: 'typedef X=Y;',
            name: 'GenericTypeAlias with Type',
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('typedef X=Y;\n')
            ],
            astVisitors: <TestAstVisitor>[
                TestNamedTypeVisitor(10, 'Y')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createDeclaration,
            inputMiddle: 'typedef F=void Function();',
            name: 'GenericTypeAlias with GenericFunctionType',
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('typedef F=void Function();\n')
            ],
            astVisitors: <TestAstVisitor>[
                TestGenericFunctionTypeVisitor(10, 'void Function()')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'GenericTypeAliasFormatter', GenericTypeAliasFormatter.new, StackTrace.current);
}
