import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/NamedTypeFormatter.dart';

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
            inputNodeCreator: AstCreator.createMethodReturnType,
            inputLeading: 'class C{',
            inputMiddle: 'D  <  A  ,  B  >  ?',
            inputTrailing: 'c() => d();}',
            name: 'NamedType / <A, B>',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<TypeArgumentList>(11, '<  A  ,  B  >')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('D<  A  ,  B  >?')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'NamedTypeFormatter', NamedTypeFormatter.new, StackTrace.current);
}
