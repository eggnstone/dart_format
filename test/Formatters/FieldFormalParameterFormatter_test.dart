import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/FieldFormalParameterFormatter.dart';

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
            inputNodeCreator: AstCreator.createFunctionDefaultFormalParameterParameter,
            inputLeading: 'void f({',
            inputMiddle: '@a  required  C  this  .  x',
            inputTrailing: '}){}',
            name: 'required C this.x',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<Annotation>(8, '@a'),
                TestVisitor<NamedType>(22, 'C')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('@a required C this.x')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'FieldFormalParameterFormatter', FieldFormalParameterFormatter.new, StackTrace.current);
}
