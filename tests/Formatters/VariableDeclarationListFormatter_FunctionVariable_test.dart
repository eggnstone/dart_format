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
            inputNodeCreator: AstCreator.createVariableDeclarationListInFunction,
            inputLeading: 'void f(){',
            inputMiddle: '@a bool b',
            inputTrailing: ';}',
            name: 'VariableDeclarationList @a bool b',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<Annotation>(9, '@a'),
                TestVisitor<NamedType>(12, 'bool'),
                TestVisitor<VariableDeclaration>(17, 'b')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'VariableDeclarationListFormatter', VariableDeclarationListFormatter.new, StackTrace.current);
}
