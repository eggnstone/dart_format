/*
import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/DefaultFormalParameterFormatter.dart';

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
            inputNodeCreator: AstCreator.createFunctionDefaultFormalParameter,
            inputLeading: 'void f(',
            inputMiddle: '  {  required  T  t  }  ',
            inputTrailing: '){}',
            name: '{required T t} (too much spacing)',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(18, 'T')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('T t')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'DefaultFormalParameterFormatter', DefaultFormalParameterFormatter.new, StackTrace.current);
}
*/
