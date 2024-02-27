import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/MixinDeclarationFormatter.dart';

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
            inputNodeCreator: AstCreator.createDeclaration,
            inputMiddle: 'mixin M on A, B{}',
            name: 'MixinDeclaration / mixin M on A, B{}',
            astVisitors: <TestVisitor<AstNode>>[
                TestVisitor<OnClause>(8, 'on A, B')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('mixin M on A, B\n{\n}\n')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'MixinDeclarationFormatter', MixinDeclarationFormatter.new, StackTrace.current);
}
