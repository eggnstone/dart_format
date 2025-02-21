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
            inputMiddle: '<  T  >  (  )  {  }',
            inputTrailing: '',
            name: 'FunctionExpression / void f<T>() {}',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<TypeParameterList>(6, '<  T  >'),
                TestVisitor<FormalParameterList>(15, '(  )'),
                TestVisitor<BlockFunctionBody>(21, '{  }')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('<  T  >  (  )  {  }'),
                TestConfig.custom('No new line before {', Config.all(addNewLineBeforeOpeningBrace: false), '<  T  >  (  ) {  }')
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
