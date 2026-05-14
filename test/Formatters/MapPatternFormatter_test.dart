import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/MapPatternFormatter.dart';

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
            inputNodeCreator: AstCreator.createMapPatternInPatternVariableDeclaration,
            inputLeading: 'void f(Map<String,int> m){var ',
            inputMiddle: '{"k":v}',
            inputTrailing: '=m;}',
            name: 'MapPattern',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<MapPatternEntry>(31, '"k":v')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('{"k":v}')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'MapPatternFormatter', MapPatternFormatter.new, StackTrace.current);
}
