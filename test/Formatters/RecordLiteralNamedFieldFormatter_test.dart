import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/RecordLiteralNamedFieldFormatter.dart';

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
            inputNodeCreator: AstCreator.createRecordLiteralNamedFieldInTopLevelVariable,
            inputLeading: 'var r=(',
            inputMiddle: 'a:1',
            inputTrailing: ',b:2);',
            name: 'RecordLiteralNamedField',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<IntegerLiteral>(9, '1')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('a: 1')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'RecordLiteralNamedFieldFormatter', RecordLiteralNamedFieldFormatter.new, StackTrace.current);
}
