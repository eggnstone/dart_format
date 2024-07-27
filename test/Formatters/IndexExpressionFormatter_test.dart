import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/IndexExpressionFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        /*TestGroupConfig(
            inputNodeCreator: AstCreator.createInitializerInVariableDeclarationInClass,
            inputLeading: 'class C{int i=',
            inputMiddle: 'a[0]',
            inputTrailing: ';}',
            name: 'IndexExpression a[0]',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(14, 'a'),
                TestVisitor<IntegerLiteral>(16, '0')
            ]
        ),*/
        TestGroupConfig(
            inputNodeCreator: AstCreator.createCascadeSectionInVariableDeclarationInClass,
            inputLeading: 'class C{int i=a',
            inputMiddle: '..[0]',
            inputTrailing: ';}',
            name: 'IndexExpression a..[0]',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<IntegerLiteral>(18, '0')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'IndexExpressionFormatter', IndexExpressionFormatter.new, StackTrace.current);
}
