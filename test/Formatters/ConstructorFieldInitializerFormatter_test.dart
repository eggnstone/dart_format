import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/ConstructorFieldInitializerFormatter.dart';

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
            inputNodeCreator: AstCreator.createConstructorInitializer,
            inputLeading: 'class C{C():',
            inputMiddle: 'a=0',
            inputTrailing: ';}',
            name: 'ConstructorFieldInitializer / a=0',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(12, 'a'),
                TestVisitor<IntegerLiteral>(14, '0')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('a = 0')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createConstructorInitializer,
            inputLeading: 'class C{C():',
            inputMiddle: 'this.a=0',
            inputTrailing: ';}',
            name: 'ConstructorFieldInitializer / this.a=0',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(17, 'a'),
                TestVisitor<IntegerLiteral>(19, '0')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('this.a = 0')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'ConstructorFieldInitializerFormatter', ConstructorFieldInitializerFormatter.new, StackTrace.current);
}
