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
            inputLeading: 'void f(  ',
            inputMiddle: 'T  t',
            inputTrailing: '  ){}',
            name: 'T t (too much spacing)',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(9, 'T')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('T t')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'SimpleFormalParameterFormatter', SimpleFormalParameterFormatter.new, StackTrace.current);
}
