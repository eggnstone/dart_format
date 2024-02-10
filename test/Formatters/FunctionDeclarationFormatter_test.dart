import 'package:dart_format/src/Formatters/FunctionDeclarationFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestAnnotationVisitor.dart';
import '../TestTools/Visitors/TestAstVisitor.dart';
import '../TestTools/Visitors/TestFunctionExpressionVisitor.dart';
import '../TestTools/Visitors/TestNamedTypeVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createDeclaration,
            inputMiddle: '@a void f<T>()async{}',
            astVisitors: <TestAstVisitor>[
                TestAnnotationVisitor(0, '@a'),
                TestNamedTypeVisitor(3, 'void'),
                TestFunctionExpressionVisitor(9, '<T>()async{}')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'FunctionDeclarationFormatter', FunctionDeclarationFormatter.new, StackTrace.current);
}
