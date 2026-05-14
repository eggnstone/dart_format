import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/TypeArgumentListFormatter.dart';

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
            inputNodeCreator: AstCreator.createTypeArgumentListInMethodReturnType,
            inputLeading: 'class C{D',
            inputMiddle: '<  A  ,  B  >',
            inputTrailing: 'c() => d();}',
            name: 'TypeArgumentList <A, B>',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(12, 'A'),
                TestVisitor<NamedType>(18, 'B')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('<A, B>')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createTypeArgumentListInMethodReturnType,
            inputLeading: 'class C{D',
            inputMiddle: '<\nA,\nB\n>',
            inputTrailing: 'c() => d();}',
            name: 'TypeArgumentList multi-line indents body and keeps closing > at outer level',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(11, 'A'),
                TestVisitor<NamedType>(14, 'B')
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
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'TypeArgumentListFormatter', TypeArgumentListFormatter.new, StackTrace.current);
}
