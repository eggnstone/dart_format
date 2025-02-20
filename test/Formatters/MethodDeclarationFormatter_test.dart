import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/MethodDeclarationFormatter.dart';

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
            inputNodeCreator: AstCreator.createClassMember,
            inputLeading: 'class  C  {  ',
            inputMiddle: 'c  (  )  {  }',
            inputTrailing: '  }',
            name: 'MethodDeclaration / c() {}',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<FormalParameterList>(16, '(  )'),
                TestVisitor<BlockFunctionBody>(22, '{  }')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('c(  ) {  }')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createClassMember,
            inputLeading: 'class  C  {  ',
            inputMiddle: '@a  static  void  c  (  )  {  }',
            inputTrailing: '  }',
            name: 'MethodDeclaration / @a static void c() {}',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<Annotation>(13, '@a'),
                TestVisitor<NamedType>(25, 'void'),
                TestVisitor<FormalParameterList>(34, '(  )'),
                TestVisitor<BlockFunctionBody>(40, '{  }')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('@a static void c(  ) {  }')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createClassMember,
            inputLeading: 'class  C  {  ',
            inputMiddle: 'void  c  (  )  =>  c  (  )  ;',
            inputTrailing: '  }',
            name: 'MethodDeclaration / void c() => c();',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(13, 'void'),
                TestVisitor<FormalParameterList>(22, '(  )'),
                TestVisitor<ExpressionFunctionBody>(28, '=>  c  (  )  ;')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('void c(  ) =>  c  (  )  ;')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'MethodDeclarationFormatter', MethodDeclarationFormatter.new, StackTrace.current);
}
