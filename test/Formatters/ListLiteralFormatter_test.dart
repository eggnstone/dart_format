import 'package:analyzer/src/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/ListLiteralFormatter.dart';

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
            inputLeading: 'var x = ',
            inputMiddle: '<C>[]',
            inputTrailing: ';',
            name: 'ListLiteral',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<TypeArgumentList>(8, '<C>'),
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig()
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'ListLiteralFormatter', ListLiteralFormatter.new, StackTrace.current);
}
