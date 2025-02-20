import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/FunctionDeclarationFormatter.dart';

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
            inputNodeCreator: AstCreator.createFunctionDeclaration,
            inputLeading: '',
            inputMiddle: 'void f(){}',
            inputTrailing: '',
            name: 'FunctionDeclaration void f(){}',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(0, 'void'),
                TestVisitor<FunctionExpression>(6, '(){}')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('void f(){}')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFunctionDeclaration,
            inputLeading: '',
            inputMiddle: 'void  f  (  )  {  }',
            inputTrailing: '',
            name: 'FunctionDeclaration void f(){} (too much spacing)', // TODO: too little spacing
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(0, 'void'),
                TestVisitor<FunctionExpression>(7, '  (  )  {  }')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('void f  (  )  {  }')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'FunctionDeclarationFormatter', FunctionDeclarationFormatter.new, StackTrace.current);
}
