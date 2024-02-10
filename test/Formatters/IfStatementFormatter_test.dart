import 'package:dart_format/src/Formatters/IfStatementFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestConfig.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestAstVisitor.dart';
import '../TestTools/Visitors/TestBlockVisitor.dart';
import '../TestTools/Visitors/TestBooleanLiteralVisitor.dart';
import '../TestTools/Visitors/TestEmptyStatementVisitor.dart';
import '../TestTools/Visitors/TestIfStatementVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'if (true);',
            inputTrailing: '}',
            name: 'if ;',
            astVisitors: <TestAstVisitor>[
                TestBooleanLiteralVisitor(13, 'true'),
                TestEmptyStatementVisitor(18, ';')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'if (true)\n;',
            inputTrailing: '}',
            name: r'if \n;',
            astVisitors: <TestAstVisitor>[
                TestBooleanLiteralVisitor(13, 'true'),
                TestEmptyStatementVisitor(19, ';')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('if (true)\n    ;')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'if (true){}',
            inputTrailing: '}',
            name: 'if {}',
            astVisitors: <TestAstVisitor>[
                TestBooleanLiteralVisitor(13, 'true'),
                TestBlockVisitor(18, '{}')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'if (true)\n{}',
            inputTrailing: '}',
            name: r'if \n{}',
            astVisitors: <TestAstVisitor>[
                TestBooleanLiteralVisitor(13, 'true'),
                TestBlockVisitor(19, '{}')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'if (true);else;',
            inputTrailing: '}',
            name: 'if ; else ;',
            astVisitors: <TestAstVisitor>[
                TestBooleanLiteralVisitor(13, 'true'),
                TestEmptyStatementVisitor(18, ';'),
                TestEmptyStatementVisitor(23, ';')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig()
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'if (true)\n;else\n;',
            inputTrailing: '}',
            name: r'if \n; else \n;',
            astVisitors: <TestAstVisitor>[
                TestBooleanLiteralVisitor(13, 'true'),
                TestEmptyStatementVisitor(19, ';'),
                TestEmptyStatementVisitor(25, ';')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('if (true)\n    ;else\n    ;')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'if (true)\n;else if(true)\n;',
            inputTrailing: '}',
            name: r'if \n ; else if \n ;',
            astVisitors: <TestAstVisitor>[
                TestBooleanLiteralVisitor(13, 'true'),
                TestEmptyStatementVisitor(19, ';'),
                TestIfStatementVisitor(25, 'if(true)\n;')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('if (true)\n    ;else if(true)\n;')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'if (true)\n;\nelse if(true)\n;',
            inputTrailing: '}',
            name: r'if \n ; \n else if \n ;',
            astVisitors: <TestAstVisitor>[
                TestBooleanLiteralVisitor(13, 'true'),
                TestEmptyStatementVisitor(19, ';'),
                TestIfStatementVisitor(26, 'if(true)\n;')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('if (true)\n    ;\nelse if(true)\n;')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'if (true)\n;\nelse if(true)\n{\n}',
            inputTrailing: '}',
            name: r'if \n ; \n else if \n {}',
            astVisitors: <TestAstVisitor>[
                TestBooleanLiteralVisitor(13, 'true'),
                TestEmptyStatementVisitor(19, ';'),
                TestIfStatementVisitor(26, 'if(true)\n{\n}')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('if (true)\n    ;\nelse if(true)\n{\n}')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'IfStatementFormatter', IfStatementFormatter.new, StackTrace.current);
}
