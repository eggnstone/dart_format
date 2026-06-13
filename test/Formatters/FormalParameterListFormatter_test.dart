import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Data/Config.dart';
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
                TestVisitor<RegularFormalParameter>(7, 'int i'),
                TestVisitor<RegularFormalParameter>(13, 'int j')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('(int i, int j)'),
                TestConfig.custom('removeTrailingCommas=false', Config.all(removeTrailingCommas: false), '(int i, int j,)')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFormalParameterListInFunction,
            inputLeading: 'void f',
            inputMiddle: '(int i,int j)',
            inputTrailing: '{}',
            name: '2 params, no trailing comma, formatter does not add one',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<RegularFormalParameter>(7, 'int i'),
                TestVisitor<RegularFormalParameter>(13, 'int j')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('(int i, int j)'),
                TestConfig.custom('removeTrailingCommas=false', Config.all(removeTrailingCommas: false), '(int i, int j)')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFormalParameterListInFunction,
            inputLeading: 'void f',
            inputMiddle: '(\nint i,\nint j,\n)',
            inputTrailing: '{}',
            name: '2 params, multi-line, trailing comma removed under default',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<RegularFormalParameter>(8, 'int i'),
                TestVisitor<RegularFormalParameter>(15, 'int j')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig(
                    '(\n'
                    '    int i,\n'
                    '    int j\n'
                    ')'
                ),
                TestConfig.custom(
                    'removeTrailingCommas=false',
                    Config.all(removeTrailingCommas: false),
                    '(\n'
                    '    int i,\n'
                    '    int j,\n'
                    ')'
                )
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFormalParameterListInFunction,
            inputLeading: 'void f',
            inputMiddle: '(\nint i\n)',
            inputTrailing: '{}',
            name: '1 param, multiple lines',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<RegularFormalParameter>(8, 'int i')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig(
                    '(\n'
                    '    int i\n'
                    ')'
                )
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFormalParameterListInFunction,
            inputLeading: 'void f',
            inputMiddle: '(\nint i,\nint j\n)',
            inputTrailing: '{}',
            name: '2 params, multiple lines',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<RegularFormalParameter>(8, 'int i'),
                TestVisitor<RegularFormalParameter>(15, 'int j')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig(
                    '(\n'
                    '    int i,\n'
                    '    int j\n'
                    ')'
                )
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFormalParameterListInFunction,
            inputLeading: 'void f',
            inputMiddle: '({\nint i\n})',
            inputTrailing: '{}',
            name: '1 named param, multiple lines',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<RegularFormalParameter>(9, 'int i')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig(
                    '({\n'
                    '    int i\n'
                    '})'
                )
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFormalParameterListInFunction,
            inputLeading: 'void f',
            inputMiddle: '(int i,{int j})',
            inputTrailing: '{}',
            name: '2 params, 1 normal, 1 named, single line',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<RegularFormalParameter>(7, 'int i'),
                TestVisitor<RegularFormalParameter>(14, 'int j')
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
                TestVisitor<RegularFormalParameter>(7, 'int i'),
                TestVisitor<RegularFormalParameter>(14, 'int j')
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
            name: '2 params (too much spacing)', // TODO: too little spacing
            astVisitors: <TestVisitor<void>>[
                TestVisitor<RegularFormalParameter>(9, 'int  i'),
                TestVisitor<RegularFormalParameter>(20, 'int  j')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('(int  i, int  j)')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFormalParameterListInFunction,
            inputLeading: 'void f',
            inputMiddle: '(\n    int i,\n    int j\n    // c\n)',
            inputTrailing: '{}',
            name: '2 params with trailing line comment',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<RegularFormalParameter>(12, 'int i'),
                TestVisitor<RegularFormalParameter>(23, 'int j')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'FormalParameterListFormatter', FormalParameterListFormatter.new, StackTrace.current);
}
