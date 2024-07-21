/*
import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/VariableDeclarationFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createVariableDeclarationInTopLevelVariableDeclaration,
            inputLeading: 'int ',
            inputMiddle: 'i=f\n.a\n.b',
            inputTrailing: ';',
            name: 'Multiline VariableDeclaration',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<PropertyAccess>(6, 'f\n.a\n.b')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'VariableDeclarationFormatter', VariableDeclarationFormatter.new, StackTrace.current);
}
*/
