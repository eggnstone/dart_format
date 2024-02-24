import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/ImportDirectiveFormatter.dart';

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
            inputLeading: '',
            inputMiddle: "import 'x.dart' if (a.b.c) 'y.dart' as z show a,b hide c,d;",
            inputTrailing: '',
            name: 'ImportDirective',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleStringLiteral>(7, "'x.dart'"),
                TestVisitor<Configuration>(16, "if (a.b.c) 'y.dart'"),
                TestVisitor<SimpleIdentifier>(39, 'z'),
                TestVisitor<ShowCombinator>(41, 'show a,b'),
                TestVisitor<HideCombinator>(50, 'hide c,d')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig("import 'x.dart' if (a.b.c) 'y.dart' as z show a,b hide c,d;\n")
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'ImportDirectiveFormatter', ImportDirectiveFormatter.new, StackTrace.current);
}
