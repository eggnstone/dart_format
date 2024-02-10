import 'package:dart_format/src/Formatters/ForStatementFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestConfig.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestAstVisitor.dart';
import '../TestTools/Visitors/TestEmptyStatementVisitor.dart';
import '../TestTools/Visitors/TestForPartsWithExpressionVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'for(;;);',
            inputTrailing: '}',
            name: 'ForStatement',
            astVisitors: <TestAstVisitor>[
                TestForPartsWithExpressionVisitor(13, ';;'),
                TestEmptyStatementVisitor(16, ';')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'for(;;)\n;',
            inputTrailing: '}',
            name: r'ForStatement \n',
            astVisitors: <TestAstVisitor>[
                TestForPartsWithExpressionVisitor(13, ';;'),
                TestEmptyStatementVisitor(17, ';')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('for(;;)\n    ;')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'ForStatementFormatter', ForStatementFormatter.new, StackTrace.current);
}
