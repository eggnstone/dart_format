import 'package:dart_format/src/Formatters/FunctionExpressionFormatter.dart';

import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        /*TODO
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFunctionExpression,
            inputLeading: 'void f',
            inputMiddle: '(){}',
            inputTrailing: '',
            name: 'FunctionExpression void f() {} (too little spacing)',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<FormalParameterList>(6, '()'),
                TestVisitor<BlockFunctionBody>(8, '{}')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('() {}')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFunctionExpression,
            inputLeading: 'void  f  ',
            inputMiddle: '(  )  {  }',
            inputTrailing: '',
            name: 'FunctionExpression void f() {} (too much spacing)',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<FormalParameterList>(9, '(  )'),
                TestVisitor<BlockFunctionBody>(15, '{  }')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('(  ) {  }')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFunctionExpression,
            inputLeading: 'void f',
            inputMiddle: '()\n{}',
            inputTrailing: '',
            name: r'FunctionExpression void f()\n{} (too little spacing)',
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
            inputLeading: 'void  f  ',
            inputMiddle: '(  )  \n  {  }',
            inputTrailing: '',
            name: r'FunctionExpression void f()\n{} (too much spacing)',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<FormalParameterList>(9, '(  )'),
                TestVisitor<BlockFunctionBody>(18, '{  }')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('(  )\n{  }')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFunctionExpression,
            inputLeading: 'bool f',
            inputMiddle: '()=>false;',
            inputTrailing: '',
            name: 'FunctionExpression bool f() => false; (too little spacing)',
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
            inputLeading: 'bool  f  ',
            inputMiddle: '(  )  /*''*/  =>  false  ;',
            inputTrailing: '',
            name: '1 FunctionExpression bool f() => false; (too much spacing)',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<FormalParameterList>(9, '(  )'),
                TestVisitor<ExpressionFunctionBody>(15, '/**/'),
                TestVisitor<ExpressionFunctionBody>(21, '=>  false  ;')
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
            name: '2 FunctionExpression bool f() => false; (too much spacing)',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<FormalParameterList>(9, '(  )'),
                TestVisitor<ExpressionFunctionBody>(15, '/**/'),
                TestVisitor<ExpressionFunctionBody>(21, '=>  false  ;')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                //TestConfig('(  ) =>  false  ;')
            ]
        )*/
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'FunctionExpressionFormatter', FunctionExpressionFormatter.new, StackTrace.current);
}
