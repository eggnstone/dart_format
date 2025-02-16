import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/VariableDeclarationListFormatter.dart';

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
            inputNodeCreator: AstCreator.createVariableDeclarationListInFunction,
            inputLeading: 'void f(){',
            inputMiddle: '@a  bool  b  =  true',
            inputTrailing: ';}',
            name: 'VariableDeclarationList @a bool b = true',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<Annotation>(9, '@a'),
                TestVisitor<NamedType>(13, 'bool'),
                TestVisitor<VariableDeclaration>(19, 'b  =  true')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('@a bool b  =  true')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'VariableDeclarationListFormatter', VariableDeclarationListFormatter.new, StackTrace.current);
}
