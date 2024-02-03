import 'package:dart_format/src/Formatters/BlockFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestConfig.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestAstVisitor.dart';
import '../TestTools/Visitors/TestExpressionStatementVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createBlockInFunction,
            inputLeading: 'void f()',
            inputMiddle: '{a;\nb;}',
            name: 'Block with 2 statements on 2 lines',
            astVisitors: <TestAstVisitor>[
                TestExpressionStatementVisitor(9, 'a;'),
                TestExpressionStatementVisitor(12, 'b;')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('\n{\n    a;\n    b;\n}\n')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createBlockInFunction,
            inputLeading: 'void f()',
            inputMiddle: '{\n/*Comment1*/\n/*Comment2*/a;/*Comment3*/\n/*Comment4*/b;/*Comment5*/\n/*Comment6*/}',
            name: 'Block with 2 statements on multiple lines (with comments)',
            astVisitors: <TestAstVisitor>[
                TestExpressionStatementVisitor(9, '\n/*Comment1*/\n/*Comment2*/a;'),
                TestExpressionStatementVisitor(37, '/*Comment3*/\n/*Comment4*/b;')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('\n{\n    /*Comment1*/\n    /*Comment2*/a;/*Comment3*/\n    /*Comment4*/b;/*Comment5*/\n    /*Comment6*/\n}\n')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'BlockFormatter', BlockFormatter.new, StackTrace.current);
}
