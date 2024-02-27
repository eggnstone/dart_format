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
        TestGroupConfig(
            inputNodeCreator: AstCreator.createExpressionInExpressionStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'a[0]',
            inputTrailing: ';}',
            name: 'IndexExpression a[0]',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(9, 'a'),
                TestVisitor<IntegerLiteral>(11, '0')
            ]
        ), 
        TestGroupConfig(
            inputNodeCreator: AstCreator.createCascadeSectionInStatementInFunction,
            inputLeading: 'void f(){a',
            inputMiddle: '..[0]',
            inputTrailing: ';}',
            name: 'IndexExpression a..[0]',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<IntegerLiteral>(13, '0')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createCascadeSectionInStatementInFunction,
            inputLeading: 'void f(){a\n',
            inputMiddle: '..[0]',
            inputTrailing: ';}',
            name: 'IndexExpression a..[0]',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<IntegerLiteral>(14, '0')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'IndexExpressionFormatter', IndexExpressionFormatter.new, StackTrace.current);
}
