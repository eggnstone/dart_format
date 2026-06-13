import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/NamedArgumentFormatter.dart';

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
            inputNodeCreator: AstCreator.createNamedArgumentInArgumentList,
            inputLeading: 'void f(){g(',
            inputMiddle: 'n:1',
            inputTrailing: ');}',
            name: 'NamedArgument',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<IntegerLiteral>(13, '1')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('n: 1')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'NamedArgumentFormatter', NamedArgumentFormatter.new, StackTrace.current);
}
