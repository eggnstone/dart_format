import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/ForPartsWithDeclarationsFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createForLoopPartsInFunction,
            inputLeading: 'void f(){for(',
            inputMiddle: 'int i=0,j=0;;i++,j--',
            inputTrailing: ');}',
            name: 'ForPartsWithDeclarations: int i=0,j=0;;i++,j--',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<VariableDeclarationList>(13, 'int i=0,j=0'),
                TestVisitor<PostfixExpression>(26, 'i++'),
                TestVisitor<PostfixExpression>(30, 'j--')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'ForPartsWithDeclarationsFormatter', ForPartsWithDeclarationsFormatter.new, StackTrace.current);
}
