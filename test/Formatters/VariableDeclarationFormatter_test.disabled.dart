/*
import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/VariableDeclarationFormatter.dart';
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
            inputNodeCreator: AstCreator.createVariableDeclarationInTopLevelVariableDeclaration,
            inputLeading: 'bool ',
            inputMiddle: 'b = true\n&& false',
            inputTrailing: ';',
            name: 'Multiline VariableDeclaration',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<BinaryExpression>(9, 'true\n&& false')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'VariableDeclarationFormatter', VariableDeclarationFormatter.new, StackTrace.current);
}
*/
