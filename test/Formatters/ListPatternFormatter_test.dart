import 'package:analyzer/src/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/ListPatternFormatter.dart';

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
            inputNodeCreator: _getListPattern,
            inputLeading: 'void f(){if (i case',
            inputMiddle: '<  int  >  [  final  int  j  ,  final  int  k  ]',
            inputTrailing: ');}',
            name: 'ListPattern / <int>[final int j, final int k]',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<TypeArgumentList>(19, '<  int  >'),
                TestVisitor<DeclaredVariablePattern>(33, 'final  int  j'),
                TestVisitor<DeclaredVariablePattern>(51, 'final  int  k')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('<  int  >[final  int  j, final  int  k]')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'ListPatternFormatter', ListPatternFormatter.new, StackTrace.current);
}

DartPattern _getListPattern(String s)
{
    final IfStatement ifStatement = AstCreator.createIfStatementInFunction(s);
    return ifStatement.caseClause!.guardedPattern.pattern;
}
