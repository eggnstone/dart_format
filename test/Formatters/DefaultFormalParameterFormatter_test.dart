import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/DefaultFormalParameterFormatter.dart';

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
            inputNodeCreator: AstCreator.createFunctionDefaultFormalParameter,
            inputLeading: 'void f({',
            inputMiddle: 'required  T  t  :  null',
            inputTrailing: '}){}',
            name: '{required T t: null} (too much spacing)', // TODO: too little spacing
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleFormalParameter>(8, 'required  T  t'),
                TestVisitor<NullLiteral>(27, 'null')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('required  T  t: null')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFunctionDefaultFormalParameter,
            inputLeading: 'void f({',
            inputMiddle: 'required  this  .  x  =  1',
            inputTrailing: '}){}',
            name: '{required this.x = 1} (too much spacing)', // TODO: too little spacing
            astVisitors: <TestVisitor<void>>[
                TestVisitor<FieldFormalParameter>(8, 'required  this  .  x'),
                TestVisitor<IntegerLiteral>(33, '1')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('required  this  .  x = 1')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'DefaultFormalParameterFormatter', DefaultFormalParameterFormatter.new, StackTrace.current);
}
