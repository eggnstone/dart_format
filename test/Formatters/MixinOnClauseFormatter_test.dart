import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/MixinOnClauseFormatter.dart';

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
            inputNodeCreator: AstCreator.createMixinOnClauseInMixinDeclaration,
            inputLeading: 'mixin M ',
            inputMiddle: 'on A,B',
            inputTrailing: '{}',
            name: 'MixinOnClause with two superclass constraints',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(11, 'A'),
                TestVisitor<NamedType>(13, 'B')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('on A, B')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'MixinOnClauseFormatter', MixinOnClauseFormatter.new, StackTrace.current);
}
