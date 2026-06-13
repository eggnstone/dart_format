import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/FormalParameterDefaultClauseFormatter.dart';

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
            inputNodeCreator: AstCreator.createFormalParameterDefaultClauseInFunction,
            inputLeading: 'void f({int x ',
            inputMiddle: '=  1',
            inputTrailing: '}){}',
            name: 'default value with = (collapses spaces around value)',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<IntegerLiteral>(17, '1')
            ],
            // The leading space in ' = 1' is an isolated-node artifact: the '='
            // separator is the clause's first token, so its "1 space before"
            // rule has nothing preceding it. In real use the parameter name is
            // emitted first, so production yields 'x = 1' (see end-to-end tests).
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig(' = 1')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'FormalParameterDefaultClauseFormatter', FormalParameterDefaultClauseFormatter.new, StackTrace.current);
}
