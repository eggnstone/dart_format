import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/ObjectPatternFormatter.dart';

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
            inputNodeCreator: AstCreator.createObjectPatternInPatternVariableDeclaration,
            inputLeading: 'void f(C c){var ',
            inputMiddle: 'C(a:x)',
            inputTrailing: '=c;}',
            name: 'ObjectPattern',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(16, 'C'),
                TestVisitor<PatternField>(18, 'a:x')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('C(a:x)')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'ObjectPatternFormatter', ObjectPatternFormatter.new, StackTrace.current);
}
