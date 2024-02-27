import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/GenericTypeAliasFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestConfig.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestVisitor.dart';

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
            astVisitors: <TestVisitor<AstNode>>[
                TestVisitor<NamedType>(10, 'Y')
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
            astVisitors: <TestVisitor<AstNode>>[
                TestVisitor<GenericFunctionType>(10, 'void Function()')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'GenericTypeAliasFormatter', GenericTypeAliasFormatter.new, StackTrace.current);
}
