import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/PropertyAccessFormatter.dart';

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
            inputNodeCreator: AstCreator.createInitializerInTopLevelVariable,
            inputLeading: 'int i=',
            inputMiddle: 'f\n.a\n.b',
            inputTrailing: ';',
            name: r'PropertyAccess / f\n.a\n.b',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<PrefixedIdentifier>(6, 'f\n.a'),
                TestVisitor<SimpleIdentifier>(12, 'b')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('f\n.a\n    .b')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'PropertyAccessFormatter', PropertyAccessFormatter.new, StackTrace.current);
}
