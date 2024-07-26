import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/IfStatementFormatter.dart';

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
            inputMiddle: 'if (true);',
            inputTrailing: '}',
            name: 'if ;',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<BooleanLiteral>(13, 'true'),
                TestVisitor<EmptyStatement>(18, ';')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'if (true)\n;',
            inputTrailing: '}',
            name: r'if \n;',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<BooleanLiteral>(13, 'true'),
                TestVisitor<EmptyStatement>(19, ';')
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
            astVisitors: <TestVisitor<void>>[
                TestVisitor<BooleanLiteral>(13, 'true'),
                TestVisitor<Block>(18, '{}')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'if (true)\n{}',
            inputTrailing: '}',
            name: r'if \n{}',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<BooleanLiteral>(13, 'true'),
                TestVisitor<Block>(19, '{}')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'if (true);else;',
            inputTrailing: '}',
            name: 'if ; else ;',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<BooleanLiteral>(13, 'true'),
                TestVisitor<EmptyStatement>(18, ';'),
                TestVisitor<EmptyStatement>(23, ';')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'if (true)\n;else\n;',
            inputTrailing: '}',
            name: r'if \n; else \n;',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<BooleanLiteral>(13, 'true'),
                TestVisitor<EmptyStatement>(19, ';'),
                TestVisitor<EmptyStatement>(25, ';')
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
            astVisitors: <TestVisitor<void>>[
                TestVisitor<BooleanLiteral>(13, 'true'),
                TestVisitor<EmptyStatement>(19, ';'),
                TestVisitor<IfStatement>(25, 'if(true)\n;')
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
            astVisitors: <TestVisitor<void>>[
                TestVisitor<BooleanLiteral>(13, 'true'),
                TestVisitor<EmptyStatement>(19, ';'),
                TestVisitor<IfStatement>(26, 'if(true)\n;')
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
            astVisitors: <TestVisitor<void>>[
                TestVisitor<BooleanLiteral>(13, 'true'),
                TestVisitor<EmptyStatement>(19, ';'),
                TestVisitor<IfStatement>(26, 'if(true)\n{\n}')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('if (true)\n    ;\nelse if(true)\n{\n}')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'IfStatementFormatter', IfStatementFormatter.new, StackTrace.current);
}
