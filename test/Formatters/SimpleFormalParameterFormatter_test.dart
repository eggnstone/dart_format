import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/SimpleFormalParameterFormatter.dart';

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
            inputLeading: 'void f(',
            inputMiddle: 'final  T  t',
            inputTrailing: '){}',
            name: 'final  T  t',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(14, 'T')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('final T t')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFunctionDefaultFormalParameterParameter,
            inputLeading: 'void f({',
            inputMiddle: '@a  required  T  t',
            inputTrailing: '}){}',
            name: '@a required T t',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<Annotation>(8, '@a'),
                TestVisitor<NamedType>(22, 'T')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('@a required T t')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createMethodDeclarationParametersParameter,
            inputLeading: 'class C{void f(',
            inputMiddle: 'covariant  T  t',
            inputTrailing: '){}}',
            name: 'covariant T t',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(26, 'T'),
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
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'SimpleFormalParameterFormatter', SimpleFormalParameterFormatter.new, StackTrace.current);
}
