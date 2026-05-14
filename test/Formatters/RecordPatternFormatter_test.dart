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
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createRecordPatternInPatternVariableDeclaration,
            inputLeading: 'void f((int,int,int) r){var ',
            inputMiddle: '(\na,\nb,\nc\n)',
            inputTrailing: '=r;}',
            name: 'RecordPattern multi-line indents body and keeps closing ) at outer level',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<PatternField>(30, 'a'),
                TestVisitor<PatternField>(33, 'b'),
                TestVisitor<PatternField>(36, 'c')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig(
                    '(\n'
                    '    a,\n'
                    '    b,\n'
                    '    c\n'
                    ')'
                )
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'RecordPatternFormatter', RecordPatternFormatter.new, StackTrace.current);
}
