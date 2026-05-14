import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/ExtendsClauseFormatter.dart';

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
            inputNodeCreator: AstCreator.createExtendsClauseInClassDeclaration,
            inputLeading: 'class C ',
            inputMiddle: 'extends  B',
            inputTrailing: '{}',
            name: 'ExtendsClause',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(17, 'B')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('extends B')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'ExtendsClauseFormatter', ExtendsClauseFormatter.new, StackTrace.current);
}
