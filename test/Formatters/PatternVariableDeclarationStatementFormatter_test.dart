import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/PatternVariableDeclarationStatementFormatter.dart';

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
            inputNodeCreator: AstCreator.createPatternVariableDeclarationStatementInFunction,
            inputLeading: 'void f((int,int) r){',
            inputMiddle: 'var (a,b)=r;',
            inputTrailing: '}',
            name: 'PatternVariableDeclarationStatement',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<PatternVariableDeclaration>(20, 'var (a,b)=r')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('var (a,b)=r;\n')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'PatternVariableDeclarationStatementFormatter', PatternVariableDeclarationStatementFormatter.new, StackTrace.current);
}
