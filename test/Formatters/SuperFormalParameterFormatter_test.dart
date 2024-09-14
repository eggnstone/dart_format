import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/SuperFormalParameterFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFormalParameterInFunction,
            inputLeading: 'void f(',
            inputMiddle: '@a int super.s',
            inputTrailing: '){}',
            name: 'SuperFormalParameter',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<Annotation>(7, '@a'),
                TestVisitor<NamedType>(10, 'int')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFormalParameterInDefaultFormalParameterInFunction,
            inputLeading: 'void f({',
            inputMiddle: '@a required int super.s',
            inputTrailing: '}){}',
            name: 'SuperFormalParameter with named',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<Annotation>(8, '@a'),
                TestVisitor<NamedType>(20, 'int')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'SuperFormalParameterFormatter', SuperFormalParameterFormatter.new, StackTrace.current);
}
