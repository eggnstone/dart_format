import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/RecordPatternFormatter.dart';

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
            inputNodeCreator: AstCreator.createRecordPatternInPatternVariableDeclaration,
            inputLeading: 'void f((int,int) r){var ',
            inputMiddle: '(a,b)',
            inputTrailing: '=r;}',
            name: 'RecordPattern',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<PatternField>(25, 'a'),
                TestVisitor<PatternField>(27, 'b')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('(a, b)')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'RecordPatternFormatter', RecordPatternFormatter.new, StackTrace.current);
}
