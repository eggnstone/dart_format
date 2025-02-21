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
            inputMiddle: '@a  static  T  c  <  T  >  (  )  {  }',
            inputTrailing: '  }',
            name: 'MethodDeclaration / @a static T c<T>() {}',
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
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createClassMember,
            inputLeading: 'class  C  {  ',
            inputMiddle: 'void  c  (  )  /*x*/  =>  c  (  )  ;',
            inputTrailing: '  }',
            name: 'MethodDeclaration / void c() /*x*/ => c();',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(13, 'void'),
                TestVisitor<FormalParameterList>(22, '(  )'),
                TestVisitor<ExpressionFunctionBody>(35, '=>  c  (  )  ;')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('void c(  )  /*x*/  =>  c  (  )  ;')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createClassMember,
            inputLeading: 'class  C  {  ',
            inputMiddle: 'void  c  (  )  /**/  =>  c  (  )  ;',
            inputTrailing: '  }',
            name: 'MethodDeclaration / void c() /**/ => c();',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(13, 'void'),
                TestVisitor<FormalParameterList>(22, '(  )'),
                TestVisitor<ExpressionFunctionBody>(34, '=>  c  (  )  ;')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('void c(  )  /**/  =>  c  (  )  ;')
            ]
        ),
        TestGroupConfig(
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
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createClassMember,
            inputLeading: 'class  C  {  ',
            inputMiddle: 'bool  get  b  /*x*/  =>  false  ;',
            inputTrailing: '  }',
            name: 'MethodDeclaration / bool get b /*x*/ => false;',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(13, 'bool'),
                TestVisitor<ExpressionFunctionBody>(34, '=>  false  ;')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('bool get b  /*x*/  =>  false  ;')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createClassMember,
            inputLeading: 'class  C  {  ',
            inputMiddle: 'bool  get  b  /**/  =>  false  ;',
            inputTrailing: '  }',
            name: 'MethodDeclaration / bool get b /**/ => false;',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(13, 'bool'),
                TestVisitor<ExpressionFunctionBody>(33, '=>  false  ;')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('bool get b  /**/  =>  false  ;')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createClassMember,
            inputLeading: 'class C{',
            inputMiddle: 'external  bool get  b  ;',
            inputTrailing: '}',
            name: 'MethodDeclaration / external bool get b;',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(18, 'bool'),
                TestVisitor<EmptyFunctionBody>(31, ';')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('external bool get b;')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createClassMember,
            inputLeading: 'class C{',
            inputMiddle: 'bool  operator  []  (  int  i  )  ;',
            inputTrailing: '}',
            name: 'MethodDeclaration / TODO',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(8, 'bool'),
                TestVisitor<FormalParameterList>(28, '(  int  i  )'),
                TestVisitor<EmptyFunctionBody>(42, ';'),
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('bool operator[](  int  i  );')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'MethodDeclarationFormatter', MethodDeclarationFormatter.new, StackTrace.current);
}
