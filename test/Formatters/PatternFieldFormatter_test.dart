import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/PatternFieldFormatter.dart';

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
            inputNodeCreator: AstCreator.createPatternFieldInObjectPattern,
            inputLeading: 'void f(C c){var C(',
            inputMiddle: 'a:x',
            inputTrailing: ')=c;}',
            name: 'PatternField named',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<PatternFieldName>(18, 'a:'),
                TestVisitor<DeclaredVariablePattern>(20, 'x')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('a: x')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'PatternFieldFormatter', PatternFieldFormatter.new, StackTrace.current);
}
