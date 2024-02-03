import 'package:dart_format/src/Formatters/DeclarationFormatters/ClassDeclarationFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestConfig.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestAnnotationVisitor.dart';
import '../TestTools/Visitors/TestAstVisitor.dart';
import '../TestTools/Visitors/TestConstructorDeclarationVisitor.dart';
import '../TestTools/Visitors/TestExtendsClauseVisitor.dart';
import '../TestTools/Visitors/TestImplementsClauseVisitor.dart';
import '../TestTools/Visitors/TestTypeParameterListVisitor.dart';
import '../TestTools/Visitors/TestWithClauseVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createDeclaration,
            inputMiddle: '@a abstract interface class C<T> extends E with W implements I{C();}',
            name: 'ClassDeclaration / empty constructor',
            astVisitors: <TestAstVisitor>[
                TestAnnotationVisitor(0, '@a'),
                TestTypeParameterListVisitor(29, '<T>'),
                TestExtendsClauseVisitor(33, 'extends E'),
                TestWithClauseVisitor(43, 'with W'),
                TestImplementsClauseVisitor(50, 'implements I'),
                TestConstructorDeclarationVisitor(63, 'C();')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('@a abstract interface class C<T> extends E with W implements I\n{\n    C();\n}\n')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'ClassDeclarationFormatter', ClassDeclarationFormatter.new, StackTrace.current);
}
