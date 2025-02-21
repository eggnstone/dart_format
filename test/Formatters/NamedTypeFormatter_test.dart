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
            inputMiddle: 'E  <  A  ,  B  >  ?',
            inputTrailing: 'c() => d();}',
            name: 'NamedType / E<A, B>',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<TypeArgumentList>(11, '<  A  ,  B  >'),
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('E<  A  ,  B  >?')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createMethodReturnType,
            inputLeading: 'class C{',
            inputMiddle: 'D  .  E  <  A  ,  B  >  ?',
            inputTrailing: 'c() => d();}',
            name: 'NamedType / D.E<A, B>',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<ImportPrefixReference>(8, 'D  .'),
                TestVisitor<TypeArgumentList>(17, '<  A  ,  B  >'),
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('D  .E<  A  ,  B  >?')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'NamedTypeFormatter', NamedTypeFormatter.new, StackTrace.current);
}
