import 'package:dart_format/src/Formatters/FieldDeclarationFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestConfig.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestAnnotationVisitor.dart';
import '../TestTools/Visitors/TestAstVisitor.dart';
import '../TestTools/Visitors/TestVariableDeclarationListVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFieldDeclarationInClass,
            inputLeading: 'class C{',
            inputMiddle: '@a final int i;',
            inputTrailing: '}',
            name: 'TODO',
            astVisitors: <TestAstVisitor>[
                TestAnnotationVisitor(8, '@a'),
                TestVariableDeclarationListVisitor(11, 'final int i')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('@a final int i;\n')
            ]
        ) 
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'FieldDeclarationFormatter', FieldDeclarationFormatter.new, StackTrace.current);
}
