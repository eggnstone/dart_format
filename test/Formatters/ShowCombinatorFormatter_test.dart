import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/ShowCombinatorFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createCombinatorInNamespaceDirective,
            inputLeading: "import 'x.dart' ",
            inputMiddle: 'show c,d',
            inputTrailing: ';',
            name: 'ShowCombinator',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(21, 'c'),
                TestVisitor<SimpleIdentifier>(23, 'd')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'ShowCombinatorFormatter', ShowCombinatorFormatter.new, StackTrace.current);
}
