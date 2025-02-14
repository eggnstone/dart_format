import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/FormalParameterListFormatter.dart';

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
            inputNodeCreator: AstCreator.createFormalParameterListInFunction,
            inputLeading: 'void f',
            inputMiddle: '()',
            inputTrailing: '{}',
            name: 'No params'
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFormalParameterListInFunction,
            inputLeading: 'void f',
            inputMiddle: '(int i,int j,)',
            inputTrailing: '{}',
            name: '2 param, single lines, trailing comma',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleFormalParameter>(7, 'int i'),
                TestVisitor<SimpleFormalParameter>(13, 'int j')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('(int i, int j)')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFormalParameterListInFunction,
            inputLeading: 'void f',
            inputMiddle: '(\nint i\n)',
            inputTrailing: '{}',
            name: '1 param, multiple lines',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleFormalParameter>(8, 'int i')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('(\n    int i\n)')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFormalParameterListInFunction,
            inputLeading: 'void f',
            inputMiddle: '(\nint i,\nint j\n)',
            inputTrailing: '{}',
            name: '2 params, multiple lines',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleFormalParameter>(8, 'int i'),
                TestVisitor<SimpleFormalParameter>(15, 'int j')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('(\n    int i,\n    int j\n)')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFormalParameterListInFunction,
            inputLeading: 'void f',
            inputMiddle: '({\nint i\n})',
            inputTrailing: '{}',
            name: '1 named param, multiple lines',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<DefaultFormalParameter>(9, 'int i')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('({\n    int i\n})')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFormalParameterListInFunction,
            inputLeading: 'void f',
            inputMiddle: '(int i,{int j})',
            inputTrailing: '{}',
            name: '2 params, 1 normal, 1 named, single line',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleFormalParameter>(7, 'int i'),
                TestVisitor<DefaultFormalParameter>(14, 'int j')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('(int i, {int j})')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFormalParameterListInFunction,
            inputLeading: 'void f',
            inputMiddle: '(int i,[int j])',
            inputTrailing: '{}',
            name: '2 params, 1 normal, 1 optional, single line',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleFormalParameter>(7, 'int i'),
                TestVisitor<DefaultFormalParameter>(14, 'int j')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('(int i, [int j])')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFormalParameterListInFunction,
            inputLeading: 'void f',
            inputMiddle: '(  int  i  ,  int  j  )',
            inputTrailing: '{}',
            name: '2 params (too much spacing)',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleFormalParameter>(9, 'int  i'),
                TestVisitor<SimpleFormalParameter>(20, 'int  j')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('(int  i, int  j)')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'FormalParameterListFormatter', FormalParameterListFormatter.new, StackTrace.current);
}
