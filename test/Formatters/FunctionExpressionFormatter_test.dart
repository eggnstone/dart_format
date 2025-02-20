import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/dart_format.dart';
import 'package:dart_format/src/Formatters/FunctionExpressionFormatter.dart';

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
            inputNodeCreator: AstCreator.createFunctionExpression,
            inputLeading: 'void f',
            inputMiddle: '(){}',
            inputTrailing: '',
            name: 'FunctionExpression / void f() {} (too little spacing)',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<FormalParameterList>(6, '()'),
                TestVisitor<BlockFunctionBody>(8, '{}')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('(){}'),
                TestConfig.custom('No new line before {', Config.all(addNewLineBeforeOpeningBrace: false), '() {}')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFunctionExpression,
            inputLeading: 'void f',
            inputMiddle: '(  )  {  }',
            inputTrailing: '',
            name: 'FunctionExpression / void f() {} (too much spacing)',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<FormalParameterList>(6, '(  )'),
                TestVisitor<BlockFunctionBody>(12, '{  }')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('(  )  {  }'),
                TestConfig.custom('No new line before {', Config.all(addNewLineBeforeOpeningBrace: false), '(  ) {  }')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFunctionExpression,
            inputLeading: 'void f',
            inputMiddle: '()\n{}',
            inputTrailing: '',
            name: r'FunctionExpression / void f()\n{} (too little spacing)',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<FormalParameterList>(6, '()'),
                TestVisitor<BlockFunctionBody>(9, '{}')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('()\n{}')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFunctionExpression,
            inputLeading: 'void f',
            inputMiddle: '(  )  \n  {  }',
            inputTrailing: '',
            name: r'FunctionExpression / void f()\n{} (too much spacing)',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<FormalParameterList>(6, '(  )'),
                TestVisitor<BlockFunctionBody>(15, '{  }')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('(  )  \n{  }')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFunctionExpression,
            inputLeading: 'bool f',
            inputMiddle: '()=>false;',
            inputTrailing: '',
            name: 'FunctionExpression / bool f() => false; (too little spacing)',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<FormalParameterList>(6, '()'),
                TestVisitor<ExpressionFunctionBody>(8, '=>false;')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('() =>false;')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFunctionExpression,
            inputLeading: 'bool f',
            inputMiddle: '(  )  =>  false;',
            inputTrailing: '',
            name: 'FunctionExpression / bool f() => false; (too much spacing)',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<FormalParameterList>(6, '(  )'),
                TestVisitor<ExpressionFunctionBody>(12, '=>  false;')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('(  ) =>  false;')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFunctionExpression,
            inputLeading: 'bool  f',
            inputMiddle: '(  )  /**/  =>  false  ;',
            inputTrailing: '',
            name: 'FunctionExpression / bool f() /**/ => false; (too much spacing)',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<FormalParameterList>(7, '(  )'),
                TestVisitor<ExpressionFunctionBody>(19, '=>  false  ;')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('(  ) =>  false  ;')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFunctionExpression,
            inputLeading: 'bool  f  ',
            inputMiddle: '(  )  /*x*/  =>  false  ;',
            inputTrailing: '',
            name: 'FunctionExpression / bool f() /*x*/ => false; (too much spacing)',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<FormalParameterList>(9, '(  )'),
                TestVisitor<ExpressionFunctionBody>(22, '=>  false  ;')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('(  ) =>  false  ;')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'FunctionExpressionFormatter', FunctionExpressionFormatter.new, StackTrace.current);
}
