import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/FieldDeclarationFormatter.dart';

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
            inputNodeCreator: AstCreator.createFieldDeclarationInClass,
            inputLeading: 'class C{',
            inputMiddle: '@a int i;',
            inputTrailing: '}',
            name: 'FieldDeclaration @a int i;',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<Annotation>(8, '@a'),
                TestVisitor<VariableDeclarationList>(11, 'int i')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('@a int i;\n')
            ]
        ) 
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'FieldDeclarationFormatter', FieldDeclarationFormatter.new, StackTrace.current);
}
