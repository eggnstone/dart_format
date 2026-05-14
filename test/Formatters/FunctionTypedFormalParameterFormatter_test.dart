import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/FunctionTypedFormalParameterFormatter.dart';

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
            inputNodeCreator: AstCreator.createFunctionTypedFormalParameterInFunction,
            inputLeading: 'void g(',
            inputMiddle: 'void f()',
            inputTrailing: '){}',
            name: 'FunctionTypedFormalParameter',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(7, 'void'),
                TestVisitor<FormalParameterList>(13, '()')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('void f()')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'FunctionTypedFormalParameterFormatter', FunctionTypedFormalParameterFormatter.new, StackTrace.current);
}
