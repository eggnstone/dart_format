import 'package:dart_format/src/Formatters/FormalParameterListFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestConfig.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestAstVisitor.dart';
import '../TestTools/Visitors/TestDefaultFormalParameterVisitor.dart';
import '../TestTools/Visitors/TestSimpleFormalParameterVisitor.dart';

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
            astVisitors: <TestAstVisitor>[
                TestSimpleFormalParameterVisitor(7, 'int i'),
                TestSimpleFormalParameterVisitor(13, 'int j')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('(int i,int j)')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFormalParameterListInFunction,
            inputLeading: 'void f',
            inputMiddle: '(\nint i\n)',
            inputTrailing: '{}',
            name: '1 param, multiple lines',
            astVisitors: <TestAstVisitor>[
                TestSimpleFormalParameterVisitor(8, 'int i')
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
            astVisitors: <TestAstVisitor>[
                TestSimpleFormalParameterVisitor(8, 'int i'),
                TestSimpleFormalParameterVisitor(15, 'int j')
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
            astVisitors: <TestAstVisitor>[
                TestDefaultFormalParameterVisitor(9, 'int i')
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
            astVisitors: <TestAstVisitor>[
                TestSimpleFormalParameterVisitor(7, 'int i'),
                TestDefaultFormalParameterVisitor(14, 'int j')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFormalParameterListInFunction,
            inputLeading: 'void f',
            inputMiddle: '(int i,[int j])',
            inputTrailing: '{}',
            name: '2 params, 1 normal, 1 optional, single line',
            astVisitors: <TestAstVisitor>[
                TestSimpleFormalParameterVisitor(7, 'int i'),
                TestDefaultFormalParameterVisitor(14, 'int j')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'FormalParameterListFormatter', FormalParameterListFormatter.new, StackTrace.current);
}
