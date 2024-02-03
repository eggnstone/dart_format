import 'package:dart_format/src/Formatters/BlockFunctionBodyFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestAstVisitor.dart';
import '../TestTools/Visitors/TestBlockVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFunctionBodyInFunction,
            inputLeading: 'void f()',
            inputMiddle: '{a;}',
            name: 'BlockFunctionBody',
            astVisitors: <TestAstVisitor>[TestBlockVisitor(8, '{a;}')]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'BlockFunctionBodyFormatter', BlockFunctionBodyFormatter.new, StackTrace.current);
}
