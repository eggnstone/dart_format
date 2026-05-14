import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/VariableDeclarationStatementFormatter.dart';

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
            inputNodeCreator: AstCreator.createVariableDeclarationStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'int a=0;',
            inputTrailing: '}',
            name: 'VariableDeclarationStatement',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<VariableDeclarationList>(9, 'int a=0')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('int a=0;\n')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'VariableDeclarationStatementFormatter', VariableDeclarationStatementFormatter.new, StackTrace.current);
}
