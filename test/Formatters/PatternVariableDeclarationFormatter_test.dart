import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/PatternVariableDeclarationFormatter.dart';

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
            inputNodeCreator: AstCreator.createPatternVariableDeclarationInFunction,
            inputLeading: 'void f((int,int) r){',
            inputMiddle: 'var (a,b)=r',
            inputTrailing: ';}',
            name: 'PatternVariableDeclaration',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<RecordPattern>(24, '(a,b)'),
                TestVisitor<SimpleIdentifier>(30, 'r')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('var (a,b) = r')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'PatternVariableDeclarationFormatter', PatternVariableDeclarationFormatter.new, StackTrace.current);
}
