import 'package:dart_format/src/Formatters/TryStatementFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestAstVisitor.dart';
import '../TestTools/Visitors/TestBlockVisitor.dart';
import '../TestTools/Visitors/TestCatchClauseVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'try{}catch(_){}finally{}',
            inputTrailing: '}',
            name: 'TryStatement',
            astVisitors: <TestAstVisitor>[
                TestBlockVisitor(12, '{}'),
                TestCatchClauseVisitor(14, 'catch(_){}'),
                TestBlockVisitor(31, '{}')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'TryStatementFormatter', TryStatementFormatter.new, StackTrace.current);
}
