/*
import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/AdjacentStringsFormatter.dart';

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
            inputLeading: 'String s=\n',
            inputMiddle: "'a'\n'b'",
            inputTrailing: ';',
            name: 'AdjacentStrings',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleStringLiteral>(10, "'a'"),
                TestVisitor<SimpleStringLiteral>(14, "'b'"),
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig("'a'\n    'b'")
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'AdjacentStringsFormatter', AdjacentStringsFormatter.new, StackTrace.current);
}
*/
