import 'package:dart_format/src/Formatters/ExportDirectiveFormatter.dart';

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
            inputMiddle: "export 'e.dart';",
            name: 'ExportDirective',
            astVisitors: <TestAstVisitor>[
                TestSimpleStringLiteralVisitor(7, "'e.dart'")
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig("export 'e.dart';\n")
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'ExportDirectiveFormatter', ExportDirectiveFormatter.new, StackTrace.current);
}
