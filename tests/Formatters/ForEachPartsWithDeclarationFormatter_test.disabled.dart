/*
import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/ForEachPartsWithDeclarationFormatter.dart';

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
            inputNodeCreator: AstCreator.createForLoopPartsInFunction,
            inputLeading: 'void f(){for(',
            inputMiddle: 'int i in[]',
            inputTrailing: '){}}',
            name: 'TODO',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<DeclaredIdentifier>(13, 'int i'),
                TestVisitor<ListLiteral>(21, '[]')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig()
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'ForEachPartsWithDeclarationFormatter', ForEachPartsWithDeclarationFormatter.new, StackTrace.current);
}
*/
