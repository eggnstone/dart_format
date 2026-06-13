import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/RecordLiteralFormatter.dart';

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
            inputLeading: 'var r=',
            inputMiddle: '(a:1,b:2)',
            inputTrailing: ';',
            name: 'RecordLiteral',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<RecordLiteralNamedField>(7, 'a:1'),
                TestVisitor<RecordLiteralNamedField>(11, 'b:2')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('(a:1,b:2)')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createInitializerInTopLevelVariable,
            inputLeading: 'var r=',
            inputMiddle: 'const (a:1,b:2)',
            inputTrailing: ';',
            name: 'RecordLiteral with const',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<RecordLiteralNamedField>(13, 'a:1'),
                TestVisitor<RecordLiteralNamedField>(17, 'b:2')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('const (a:1,b:2)')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createInitializerInTopLevelVariable,
            inputLeading: 'var r=',
            inputMiddle: '(\na:1,\nb:2\n)',
            inputTrailing: ';',
            name: 'RecordLiteral multi-line indents body and keeps closing ) at outer level',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<RecordLiteralNamedField>(8, 'a:1'),
                TestVisitor<RecordLiteralNamedField>(13, 'b:2')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig(
                    '(\n'
                    '    a:1,\n'
                    '    b:2\n'
                    ')'
                )
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'RecordLiteralFormatter', RecordLiteralFormatter.new, StackTrace.current);
}
