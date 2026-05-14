import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/MapPatternEntryFormatter.dart';

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
            inputNodeCreator: AstCreator.createMapPatternEntryInPatternVariableDeclaration,
            inputLeading: 'void f(Map<String,int> m){var {',
            inputMiddle: '"k":v',
            inputTrailing: '}=m;}',
            name: 'MapPatternEntry',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleStringLiteral>(31, '"k"'),
                TestVisitor<DeclaredVariablePattern>(35, 'v')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('"k": v')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'MapPatternEntryFormatter', MapPatternEntryFormatter.new, StackTrace.current);
}
