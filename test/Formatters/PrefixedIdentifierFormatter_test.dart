import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/PrefixedIdentifierFormatter.dart';

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
            inputNodeCreator: AstCreator.createExpressionInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'C\n.c',
            inputTrailing: ';}',
            name: r'PrefixedIdentifier / C.\nc',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(9, 'C'),
                TestVisitor<SimpleIdentifier>(12, 'c')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('C\n    .c')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createExpressionInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'C  .  c',
            inputTrailing: ';}',
            name: 'PrefixedIdentifier / C.c (too much spacing)', // TODO: too little spacing
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(9, 'C'),
                TestVisitor<SimpleIdentifier>(15, 'c')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('C.c')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'PrefixedIdentifierFormatter', PrefixedIdentifierFormatter.new, StackTrace.current);
}
