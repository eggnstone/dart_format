import 'package:dart_format/src/Formatters/PartDirectiveFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestConfig.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestAstVisitor.dart';
import '../TestTools/Visitors/TestSimpleStringLiteralVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createDirective,
            inputMiddle: "part'';",
            name: 'PartDirective',
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig("part'';\n")
            ],
            astVisitors: <TestAstVisitor>[
                TestSimpleStringLiteralVisitor(4, "''")
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'PartDirectiveFormatter', PartDirectiveFormatter.new, StackTrace.current);
}
