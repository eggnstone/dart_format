import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/LabelFormatter.dart';

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
            inputNodeCreator: AstCreator.createLabelInLabeledStatement,
            inputLeading: 'void f(){',
            inputMiddle: 'outer :',
            inputTrailing: 'while(true){}}',
            name: 'Label',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(9, 'outer')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('outer:')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'LabelFormatter', LabelFormatter.new, StackTrace.current);
}
