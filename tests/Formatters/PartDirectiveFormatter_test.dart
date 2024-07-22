import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/PartDirectiveFormatter.dart';

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
            inputNodeCreator: AstCreator.createDirective,
            inputMiddle: "part'';",
            name: 'PartDirective',
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig("part'';\n")
            ],
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleStringLiteral>(4, "''")
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'PartDirectiveFormatter', PartDirectiveFormatter.new, StackTrace.current);
}
