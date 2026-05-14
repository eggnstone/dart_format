import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/AsExpressionFormatter.dart';

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
            inputNodeCreator: AstCreator.createAsExpressionInVariable,
            inputLeading: 'void f(){var x = ',
            inputMiddle: 'a  as  B',
            inputTrailing: ';}',
            name: 'AsExpression',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(17, 'a'),
                TestVisitor<NamedType>(24, 'B')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('a as B')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'AsExpressionFormatter', AsExpressionFormatter.new, StackTrace.current);
}
