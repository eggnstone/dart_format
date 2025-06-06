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
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('if (true) {}')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'if (true)\n{}',
            inputTrailing: '}',
            name: 'if {}',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<BooleanLiteral>(13, 'true'),
                TestVisitor<Block>(19, '{}')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('if (true)\n{}')
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
            inputMiddle: 'if (true); else;',
            inputTrailing: '}',
            name: 'if ; else ;',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<BooleanLiteral>(13, 'true'),
                TestVisitor<EmptyStatement>(18, ';'),
                TestVisitor<EmptyStatement>(24, ';')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('if (true); else;')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'if (true)\n; else\n;',
            inputTrailing: '}',
            name: r'if \n; else \n;',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<BooleanLiteral>(13, 'true'),
                TestVisitor<EmptyStatement>(19, ';'),
                TestVisitor<EmptyStatement>(26, ';')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('if (true)\n    ; else\n    ;')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'if (true)\n; else if(true)\n;',
            inputTrailing: '}',
            name: r'if \n ; else if \n ;',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<BooleanLiteral>(13, 'true'),
                TestVisitor<EmptyStatement>(19, ';'),
                TestVisitor<IfStatement>(26, 'if(true)\n;')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('if (true)\n    ; else if(true)\n;')
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
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'if(true);else;',
            inputTrailing: '}',
            name: 'if ; else ; (too little spacing)',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<BooleanLiteral>(12, 'true'),
                TestVisitor<EmptyStatement>(17, ';'),
                TestVisitor<EmptyStatement>(22, ';')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('if (true); else;')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'if(true);else;',
            inputTrailing: '}',
            name: 'if ; else ; (too little spacing, with line breaks)',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<BooleanLiteral>(12, 'true'),
                TestVisitor<EmptyStatement>(17, ';', '\n'),
                TestVisitor<EmptyStatement>(22, ';', '\n')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none('if(true);\nelse;\n'),
                TestConfig('if (true);\nelse;\n')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'if  (  true  )  ;  else  ;',
            inputTrailing: '}',
            name: 'if ; else ; (too much spacing)', // TODO: too little spacing
            astVisitors: <TestVisitor<void>>[
                TestVisitor<BooleanLiteral>(16, 'true'),
                TestVisitor<EmptyStatement>(25, ';'),
                TestVisitor<EmptyStatement>(34, ';')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('if (true); else;')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'if/**/(/**/true/**/)/**/;/**/else/**/;',
            inputTrailing: '}',
            name: 'if ; else ; (too little spacing with comments)',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<BooleanLiteral>(16, '/**/true'),
                TestVisitor<EmptyStatement>(29, '/**/;'),
                TestVisitor<EmptyStatement>(42, '/**/;')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('if /**/ (/**/true /**/)/**/; /**/ else/**/;')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'if  /**/  (  /**/  true  /**/  )  /**/  ;  /**/  else  /**/  ;',
            inputTrailing: '}',
            name: 'if ; else ; (too much spacing with comments)',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<BooleanLiteral>(20, '  /**/  true'),
                TestVisitor<EmptyStatement>(41, '  /**/  ;'),
                TestVisitor<EmptyStatement>(62, '  /**/  ;')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('if /**/ (  /**/  true /**/)  /**/  ; /**/ else  /**/  ;')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'IfStatementFormatter', IfStatementFormatter.new, StackTrace.current);
}
