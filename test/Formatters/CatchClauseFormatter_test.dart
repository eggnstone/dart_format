import 'package:dart_format/src/Formatters/CatchClauseFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestAstVisitor.dart';
import '../TestTools/Visitors/TestBlockVisitor.dart';
import '../TestTools/Visitors/TestCatchClauseParameterVisitor.dart';
import '../TestTools/Visitors/TestNamedTypeVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createCatchClauseInFunction,
            inputLeading: 'void f(){try{}',
            inputMiddle: 'on Exception catch(_,__){}',
            inputTrailing: '}',
            name: 'CatchClause',
            astVisitors: <TestAstVisitor>[
                TestNamedTypeVisitor(17, 'Exception'),
                TestCatchClauseParameterVisitor(33, '_'),
                TestCatchClauseParameterVisitor(35, '__'),
                TestBlockVisitor(38, '{}')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'CatchClauseFormatter', CatchClauseFormatter.new, StackTrace.current);
}
