import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/ImplementsClauseFormatter.dart';

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
            inputNodeCreator: AstCreator.createImplementsClauseInClassDeclaration,
            inputLeading: 'class C ',
            inputMiddle: 'implements A,B',
            inputTrailing: '{}',
            name: 'ImplementsClause with two interfaces',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(19, 'A'),
                TestVisitor<NamedType>(21, 'B')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('implements A,B')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'ImplementsClauseFormatter', ImplementsClauseFormatter.new, StackTrace.current);
}
