/*
import 'package:dart_format/src/Formatters/ListFormatters/VariableDeclarationListFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestAnnotationVisitor.dart';
import '../TestTools/Visitors/TestAstVisitor.dart';
import '../TestTools/Visitors/TestNamedTypeVisitor.dart';
import '../TestTools/Visitors/TestVariableDeclarationVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createVariableDeclarationListInClass,
            inputLeading: 'class C{',
            inputMiddle: '@a List<int>list=<int>[];',
            inputTrailing: '}',
            name: 'TODO',
            astVisitors: <TestAstVisitor>[
                TestNamedTypeVisitor(8, '@a List<int>'),
                TestVariableDeclarationVisitor(20, 'list=<int>[];')
            ]
        ) 
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'VariableDeclarationListFormatter', VariableDeclarationListFormatter.new, StackTrace.current);
}
*/
