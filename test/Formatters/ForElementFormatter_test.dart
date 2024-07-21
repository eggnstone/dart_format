import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/ForElementFormatter.dart';

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
            inputNodeCreator: AstCreator.createForElement,
            inputLeading: 'void f(){x={\n',
            inputMiddle: 'for (a in b)\nc',
            inputTrailing: '};}',
            name: 'ForElement',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<ForEachPartsWithIdentifier>(18, 'a in b'),
                TestVisitor<SimpleIdentifier>(26, 'c')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('for (a in b)\n    c')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'ForElementFormatter', ForElementFormatter.new, StackTrace.current);
}
