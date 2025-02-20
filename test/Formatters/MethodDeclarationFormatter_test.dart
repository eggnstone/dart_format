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
        // old
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

        // new
        /*TestGroupConfig(
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
            inputMiddle: '@a  static  T  c  <  T  >  (  )  {  }',
            inputTrailing: '  }',
            name: 'MethodDeclaration / @a static void c() {}',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<Annotation>(13, '@a'),
                TestVisitor<NamedType>(25, 'T'),
                TestVisitor<TypeParameterList>(31, '<  T  >'),
                TestVisitor<FormalParameterList>(40, '(  )'),
                TestVisitor<BlockFunctionBody>(46, '{  }')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('@a static T c<  T  >(  ) {  }')
            ]
        ),*/
        /*
        TestGroupConfig(
            inputNodeCreator: AstCreator.createClassMember,
            inputLeading: 'class  C  {  ',
            inputMiddle: 'void  c  (  )  /*x*/  =>  c  (  )  ;',
            inputTrailing: '  }',
            name: '1 MethodDeclaration / void c() => c();',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(13, 'void'),
                TestVisitor<FormalParameterList>(22, '(  )'),
                TestVisitor<ExpressionFunctionBody>(28, '=>  c  (  )  ;')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('void c(  ) =>  c  (  )  ;')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createClassMember,
            inputLeading: 'class  C  {  ',
            inputMiddle: 'void  c  (  )  /**/  =>  c  (  )  ;',
            inputTrailing: '  }',
            name: '2 MethodDeclaration / void c() => c();',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(13, 'void'),
                TestVisitor<FormalParameterList>(22, '(  )'),
                TestVisitor<ExpressionFunctionBody>(28, '=>  c  (  )  ;')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('void c(  ) =>  c  (  )  ;')
            ]
        ),
        */
        /*TestGroupConfig(
            inputNodeCreator: AstCreator.createClassMember,
            inputLeading: 'class  C  {  ',
            inputMiddle: 'bool  get  b  =>  false  ;',
            inputTrailing: '  }',
            name: 'MethodDeclaration / bool get b => false;',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(13, 'bool'),
                TestVisitor<ExpressionFunctionBody>(27, '=>  false  ;')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('bool get b =>  false  ;')
            ]
        )*/
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'MethodDeclarationFormatter', MethodDeclarationFormatter.new, StackTrace.current);
}
