import 'package:dart_format/src/Formatters/StatementFormatters/WhileStatementFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestConfig.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestAstVisitor.dart';
import '../TestTools/Visitors/TestBlockVisitor.dart';
import '../TestTools/Visitors/TestBooleanLiteralVisitor.dart';
import '../TestTools/Visitors/TestEmptyStatementVisitor.dart';

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
            astVisitors: <TestAstVisitor>[
                TestBooleanLiteralVisitor(15, 'true'),
                TestEmptyStatementVisitor(21, ';')
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
            astVisitors: <TestAstVisitor>[
                TestBooleanLiteralVisitor(15, 'true'),
                TestBlockVisitor(20, '{}')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'WhileStatementFormatter', WhileStatementFormatter.new, StackTrace.current);
}
