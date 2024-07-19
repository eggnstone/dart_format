import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/FunctionTypeAliasFormatter.dart';

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
            inputNodeCreator: AstCreator.createFunctionTypeAlias,
            inputLeading: '',
            inputMiddle: '@a typedef void f();',
            inputTrailing: '',
            name: 'FunctionTypeAliasFormatter @a typedef void f();',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<Annotation>(0, '@a'),
                TestVisitor<NamedType>(11, 'void'),
                TestVisitor<FormalParameterList>(17, '()')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('@a typedef void f();\n')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'FunctionTypeAliasFormatter', FunctionTypeAliasFormatter.new, StackTrace.current);
}
