import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/RegularFormalParameterFormatter.dart';

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
            inputNodeCreator: AstCreator.createFunctionParameter,
            inputLeading: 'void f(',
            inputMiddle: 't',
            inputTrailing: '){}',
            name: 't',
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('t')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFunctionParameter,
            inputLeading: 'void f({',
            inputMiddle: '@a  required  final  T  t',
            inputTrailing: '}){}',
            name: '@a required final T t',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<Annotation>(8, '@a'),
                TestVisitor<NamedType>(29, 'T')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('@a required final T t')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createMethodDeclarationParametersParameter,
            inputLeading: 'class C{void f(',
            inputMiddle: 'covariant  T  t',
            inputTrailing: '){}}',
            name: 'covariant T t',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(26, 'T')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('covariant T t')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFunctionParameter,
            inputLeading: 'void f(',
            inputMiddle: 'var  t',
            inputTrailing: '){}',
            name: 'var t',
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('var t')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFormalParameterInFunction,
            inputLeading: 'void f(',
            inputMiddle: '@a void g()?',
            inputTrailing: '){}',
            name: 'function-typed @a void g()?',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<Annotation>(7, '@a'),
                TestVisitor<NamedType>(10, 'void'),
                TestVisitor<FunctionTypedFormalParameterSuffix>(16, '()?')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createMethodDeclarationParametersParameter,
            inputLeading: 'class C{void m(',
            inputMiddle: 'covariant void g()',
            inputTrailing: '){}}',
            name: 'function-typed with covariant',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(25, 'void'),
                TestVisitor<FunctionTypedFormalParameterSuffix>(31, '()')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFunctionParameter,
            inputLeading: 'void f({',
            inputMiddle: 'required void g()',
            inputTrailing: '}){}',
            name: 'function-typed with required',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(17, 'void'),
                TestVisitor<FunctionTypedFormalParameterSuffix>(23, '()')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFormalParameterInFunction,
            inputLeading: 'void f(',
            inputMiddle: 'int g<T>(T s)',
            inputTrailing: '){}',
            name: 'function-typed with typeParameters',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(7, 'int'),
                TestVisitor<FunctionTypedFormalParameterSuffix>(12, '<T>(T s)')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFormalParameterInFunctionTolerant,
            inputLeading: 'void f(',
            inputMiddle: 'final void g()',
            inputTrailing: '){}',
            name: 'function-typed with keyword',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(13, 'void'),
                TestVisitor<FunctionTypedFormalParameterSuffix>(19, '()')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'RegularFormalParameterFormatter', RegularFormalParameterFormatter.new, StackTrace.current);
}
