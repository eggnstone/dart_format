import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/WithClauseFormatter.dart';

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
            inputNodeCreator: AstCreator.createWithClauseInClassDeclaration,
            inputLeading: 'class C extends B ',
            inputMiddle: 'with M,N',
            inputTrailing: '{}',
            name: 'WithClause with two mixins',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(23, 'M'),
                TestVisitor<NamedType>(25, 'N')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('with M,N')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'WithClauseFormatter', WithClauseFormatter.new, StackTrace.current);
}
