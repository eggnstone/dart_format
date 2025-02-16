import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/TopLevelVariableDeclarationFormatter.dart';

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
            inputNodeCreator: AstCreator.createTopLevelVariableDeclaration,
            inputLeading: '',
            inputMiddle: 'external  int  i  =  f  .  a  .  b;',
            inputTrailing: '',
            name: 'TopLevelVariableDeclaration external int i = f.a.b;',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<VariableDeclarationList>(10, 'int  i  =  f  .  a  .  b')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('external  int  i  =  f  .  a  .  b;\n')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'TopLevelVariableDeclarationFormatter', TopLevelVariableDeclarationFormatter.new, StackTrace.current);
}
