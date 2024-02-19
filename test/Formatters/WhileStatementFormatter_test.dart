import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/WhileStatementFormatter.dart';

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
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'while(true)\n;',
            inputTrailing: '}',
            name: 'while(true);',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<BooleanLiteral>(15, 'true'),
                TestVisitor<EmptyStatement>(21, ';')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('while(true)\n    ;')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'while(true){}',
            inputTrailing: '}',
            name: 'while(true){}',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<BooleanLiteral>(15, 'true'),
                TestVisitor<Block>(20, '{}')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'WhileStatementFormatter', WhileStatementFormatter.new, StackTrace.current);
}
