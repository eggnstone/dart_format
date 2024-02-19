import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/ClassDeclarationFormatter.dart';

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
            inputNodeCreator: AstCreator.createDeclaration,
            inputMiddle: '@a abstract interface class C<T> extends E with W implements I{C();}',
            name: 'ClassDeclaration / empty constructor',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<Annotation>(0, '@a'),
                TestVisitor<TypeParameterList>(29, '<T>'),
                TestVisitor<ExtendsClause>(33, 'extends E'),
                TestVisitor<WithClause>(43, 'with W'),
                TestVisitor<ImplementsClause>(50, 'implements I'),
                TestVisitor<ConstructorDeclaration>(63, 'C();')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('@a abstract interface class C<T> extends E with W implements I\n{\n    C();\n}\n')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'ClassDeclarationFormatter', ClassDeclarationFormatter.new, StackTrace.current);
}
