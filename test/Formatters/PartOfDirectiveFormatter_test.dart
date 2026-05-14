import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/PartOfDirectiveFormatter.dart';

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
            inputNodeCreator: AstCreator.createPartOfDirective,
            inputMiddle: "part of 'a.dart';",
            name: 'PartOfDirective with uri',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleStringLiteral>(8, "'a.dart'")
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig("part of 'a.dart';\n")
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createPartOfDirective,
            inputMiddle: 'part of a;',
            name: 'PartOfDirective with library name',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<DottedName>(8, 'a')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('part of a;\n')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'PartOfDirectiveFormatter', PartOfDirectiveFormatter.new, StackTrace.current);
}
