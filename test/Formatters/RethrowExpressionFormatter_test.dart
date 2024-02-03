import 'package:dart_format/src/Formatters/ExpressionFormatters/RethrowExpressionFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createExpressionInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'rethrow',
            inputTrailing: ';}',
            name: 'RethrowExpression'
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'RethrowExpressionFormatter', RethrowExpressionFormatter.new, StackTrace.current);
}
