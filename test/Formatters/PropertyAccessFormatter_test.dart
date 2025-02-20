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
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createInitializerInTopLevelVariable,
            inputLeading: 'int i=',
            inputMiddle: 'f  .  a  .  b',
            inputTrailing: ';',
            name: 'PropertyAccess / f.a.b (too much spacing)',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<PrefixedIdentifier>(6, 'f  .  a'),
                TestVisitor<SimpleIdentifier>(18, 'b')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('f  .  a.b')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createInitializerInTopLevelVariable,
            inputLeading: 'int i=',
            inputMiddle: 'f  .  a  .  b  .  c',
            inputTrailing: ';',
            name: 'PropertyAccess / f.a.b.c (too much spacing)',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<PropertyAccess>(6, 'f  .  a  .  b'),
                TestVisitor<SimpleIdentifier>(24, 'c')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('f  .  a  .  b.c')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'PropertyAccessFormatter', PropertyAccessFormatter.new, StackTrace.current);
}
