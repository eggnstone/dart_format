import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/ConstructorDeclarationFormatter.dart';

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
            inputLeading: 'class C{',
            inputMiddle: 'const C();',
            inputTrailing: '}',
            name: 'const / no params',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(14, 'C'),
                TestVisitor<FormalParameterList>(15, '()'),
                TestVisitor<EmptyFunctionBody>(17, ';')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createClassMember,
            inputLeading: 'class C{',
            inputMiddle: 'const C(int i);',
            inputTrailing: '}',
            name: 'const / 1 param',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(14, 'C'),
                TestVisitor<FormalParameterList>(15, '(int i)'),
                TestVisitor<EmptyFunctionBody>(22, ';')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createClassMember,
            inputLeading: 'class C{',
            inputMiddle: 'const C({int i});',
            inputTrailing: '}',
            name: 'const / 1 named param',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(14, 'C'),
                TestVisitor<FormalParameterList>(15, '({int i})'),
                TestVisitor<EmptyFunctionBody>(24, ';')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createClassMember,
            inputLeading: 'class C{',
            inputMiddle: '@a factory C(){}',
            inputTrailing: '}',
            name: 'With annotated factory with class name only',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<Annotation>(8, '@a'),
                TestVisitor<SimpleIdentifier>(19, 'C'),                
                TestVisitor<FormalParameterList>(20, '()'),
                TestVisitor<BlockFunctionBody>(22, '{}')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createClassMember,
            inputLeading:  'class C{',
            inputMiddle: 'factory C.f(){}',
            inputTrailing: '}',
            name: 'With factory with class+factory name',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(16, 'C'),
                TestVisitor<FormalParameterList>(19, '()'),
                TestVisitor<BlockFunctionBody>(21, '{}')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createClassMember,
            inputLeading: 'class C{',
            inputMiddle: 'const factory C()=_C;',
            inputTrailing: '}',
            name: 'With factory with redirect',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(22, 'C'),
                TestVisitor<FormalParameterList>(23, '()'),
                TestVisitor<ConstructorName>(26, '_C'),
                TestVisitor<EmptyFunctionBody>(28, ';')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('const factory C() =_C;')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createClassMember,
            inputLeading: 'class C{',
            inputMiddle:  'C():super(){}',
            inputTrailing: '}',
            name: 'With super',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(8, 'C'),
                TestVisitor<FormalParameterList>(9, '()'),
                TestVisitor<SuperConstructorInvocation>(12, 'super()'),
                TestVisitor<BlockFunctionBody>(19, '{}')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('C() :super(){}')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createClassMember,
            inputLeading: 'class C{',
            inputMiddle:  'const C():super();',
            inputTrailing: '}',
            name: 'Const with super',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(14, 'C'),
                TestVisitor<FormalParameterList>(15, '()'),
                TestVisitor<SuperConstructorInvocation>(18, 'super()'),
                TestVisitor<EmptyFunctionBody>(25, ';')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('const C() :super();')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createClassMember,
            inputLeading: 'class C{',
            inputMiddle: 'const C():a=0,b=0;',
            inputTrailing: '}',
            name: 'With initializers (1 line)',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(14, 'C'),
                TestVisitor<FormalParameterList>(15, '()'),
                TestVisitor<ConstructorFieldInitializer>(18, 'a=0'),
                TestVisitor<ConstructorFieldInitializer>(22, 'b=0'),
                TestVisitor<EmptyFunctionBody>(25, ';')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('const C() :a=0,b=0;')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createClassMember,
            inputLeading: 'class C{',
            inputMiddle: 'const C()\n:a=0,b=0;',
            inputTrailing: '}',
            name: 'With initializers (2 lines)',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(14, 'C'),
                TestVisitor<FormalParameterList>(15, '()'),
                TestVisitor<ConstructorFieldInitializer>(19, 'a=0'),
                TestVisitor<ConstructorFieldInitializer>(23, 'b=0'),
                TestVisitor<EmptyFunctionBody>(26, ';')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('const C()\n    :a=0,b=0;')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createClassMember,
            inputLeading: 'class C{',
            inputMiddle: 'const C()\n:a=0,\nb=0;',
            inputTrailing: '}',
            name: 'With initializers (3 lines)',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(14, 'C'),
                TestVisitor<FormalParameterList>(15, '()'),
                TestVisitor<ConstructorFieldInitializer>(19, 'a=0'),
                TestVisitor<ConstructorFieldInitializer>(24, 'b=0'),
                TestVisitor<EmptyFunctionBody>(27, ';')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('const C()\n    :a=0,\n    b=0;')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'ConstructorDeclarationFormatter', ConstructorDeclarationFormatter.new, StackTrace.current);
}
