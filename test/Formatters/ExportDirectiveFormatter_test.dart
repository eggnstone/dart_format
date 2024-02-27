import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/ExportDirectiveFormatter.dart';

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
            inputMiddle: "export 'x.dart' if (a.b.c) 'y.dart';",
            name: 'ExportDirective',
            astVisitors: <TestVisitor<AstNode>>[
                TestVisitor<SimpleStringLiteral>(7, "'x.dart'"),
                TestVisitor<Configuration>(16, "if (a.b.c) 'y.dart'")
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig("export 'x.dart' if (a.b.c) 'y.dart';\n")
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'ExportDirectiveFormatter', ExportDirectiveFormatter.new, StackTrace.current);
}
