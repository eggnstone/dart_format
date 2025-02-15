import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/SimpleFormalParameterFormatter.dart';

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
            inputNodeCreator: AstCreator.createFunctionParameter,
            inputLeading: 'void f(  ',
            inputMiddle: '@a  T  t',
            inputTrailing: '  ){}',
            name: '@a T t (too much spacing)',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<Annotation>(9, '@a'),
                TestVisitor<NamedType>(13, 'T')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('@a T t')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFunctionDefaultFormalParameterParameter,
            inputLeading: 'void f({  ',
            inputMiddle: '@a  required  T  t',
            inputTrailing: '  }){}',
            name: '@a required T t (too much spacing)',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<Annotation>(10, '@a'),
                TestVisitor<NamedType>(24, 'T')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('@a required T t')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'SimpleFormalParameterFormatter', SimpleFormalParameterFormatter.new, StackTrace.current);
}
