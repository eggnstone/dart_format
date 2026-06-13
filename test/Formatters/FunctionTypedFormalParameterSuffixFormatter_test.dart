import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/FunctionTypedFormalParameterSuffixFormatter.dart';

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
            inputNodeCreator: AstCreator.createFunctionTypedFormalParameterSuffixInFunction,
            inputLeading: 'void f(void g',
            inputMiddle: '()',
            inputTrailing: '){}',
            name: 'FunctionTypedFormalParameterSuffix ()',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<FormalParameterList>(13, '()')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('()')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFunctionTypedFormalParameterSuffixInFunction,
            inputLeading: 'void f(int g',
            inputMiddle: '<T>(T s)?',
            inputTrailing: '){}',
            name: 'FunctionTypedFormalParameterSuffix with typeParameters and question',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<TypeParameterList>(12, '<T>'),
                TestVisitor<FormalParameterList>(15, '(T s)')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('<T>(T s)?')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'FunctionTypedFormalParameterSuffixFormatter', FunctionTypedFormalParameterSuffixFormatter.new, StackTrace.current);
}
