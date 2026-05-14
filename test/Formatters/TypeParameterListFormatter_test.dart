import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/TypeParameterListFormatter.dart';

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
            inputNodeCreator: AstCreator.createTypeParameterListInFunction,
            inputLeading: 'void f',
            inputMiddle: '<  A  ,  B  >',
            inputTrailing: '(){}',
            name: 'TypeParameterList <A, B>',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<TypeParameter>(9, 'A'),
                TestVisitor<TypeParameter>(15, 'B')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('<A, B>')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createTypeParameterListInFunction,
            inputLeading: 'void f',
            inputMiddle: '<\nA,\nB\n>',
            inputTrailing: '(){}',
            name: 'TypeParameterList multi-line closing > stays at outer level',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<TypeParameter>(8, 'A'),
                TestVisitor<TypeParameter>(11, 'B')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig(
                    '<\n'
                    '    A,\n'
                    '    B\n'
                    '>'
                )
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createTypeParameterListInFunction,
            inputLeading: 'void f',
            inputMiddle: '<\n    A,\n    B\n    >',
            inputTrailing: '(){}',
            name: 'TypeParameterList multi-line normalizes mis-indented closing >',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<TypeParameter>(12, 'A'),
                TestVisitor<TypeParameter>(19, 'B')
            ],
            testConfigs: <TestConfig>[
                TestConfig(
                    '<\n'
                    '    A,\n'
                    '    B\n'
                    '>'
                )
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'TypeParameterListFormatter', TypeParameterListFormatter.new, StackTrace.current);
}
