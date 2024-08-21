import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/ClassTypeAliasFormatter.dart';

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
            inputMiddle: 'abstract class C=B with M;',
            name: 'ClassTypeAlias abstract class C=B with M',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(17, 'B'),
                TestVisitor<WithClause>(19, 'with M')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('abstract class C=B with M;\n')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'ClassTypeAliasFormatter', ClassTypeAliasFormatter.new, StackTrace.current);
}
