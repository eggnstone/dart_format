import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/FunctionTypedFormalParameterFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFormalParameterInFunction,
            inputLeading: 'void f(',
            inputMiddle: '@a void g()?',
            inputTrailing: '){}',
            name: 'FunctionTypedFormalParameter @a void g()?',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<Annotation>(7, '@a'),
                TestVisitor<NamedType>(10, 'void'),
                TestVisitor<FormalParameterList>(16, '()')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createMethodDeclarationParametersParameter,
            inputLeading: 'class C{void m(',
            inputMiddle: 'covariant void g()',
            inputTrailing: '){}}',
            name: 'FunctionTypedFormalParameter with covariant',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(25, 'void'),
                TestVisitor<FormalParameterList>(31, '()')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFunctionDefaultFormalParameterParameter,
            inputLeading: 'void f({',
            inputMiddle: 'required void g()',
            inputTrailing: '}){}',
            name: 'FunctionTypedFormalParameter with required',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(17, 'void'),
                TestVisitor<FormalParameterList>(23, '()')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'FunctionTypedFormalParameterFormatter', FunctionTypedFormalParameterFormatter.new, StackTrace.current);
}
