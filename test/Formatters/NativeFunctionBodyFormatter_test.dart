import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/NativeFunctionBodyFormatter.dart';

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
            inputNodeCreator: AstCreator.createNativeFunctionBodyInClass,
            inputLeading: 'class C{void g()',
            inputMiddle: "native 'n';",
            inputTrailing: '}',
            name: 'NativeFunctionBody',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleStringLiteral>(23, "'n'")
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig("native 'n';\n")
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'NativeFunctionBodyFormatter', NativeFunctionBodyFormatter.new, StackTrace.current);
}
