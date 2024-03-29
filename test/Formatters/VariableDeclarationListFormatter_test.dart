import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/VariableDeclarationListFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createVariableDeclarationListInClass,
            inputLeading: 'class C{',
            inputMiddle: 'late final int i = 0',
            inputTrailing: ';}',
            name: 'VariableDeclarationList late final int i = 0;',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(19, 'int'),
                TestVisitor<VariableDeclaration>(23, 'i = 0')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'VariableDeclarationListFormatter', VariableDeclarationListFormatter.new, StackTrace.current);
}
