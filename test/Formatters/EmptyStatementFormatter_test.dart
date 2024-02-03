import 'package:dart_format/src/Formatters/StatementFormatters/EmptyStatementFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestConfig.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: ';',
            inputTrailing: '}',
            name: 'Simple',
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig(';\n')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: ';',
            inputTrailing: '//Comment1\n//Comment2\n}',
            name: 'Line comment'
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: ';',
            inputTrailing: '/*Comment1*/\n/*Comment2*/}',
            name: 'Block comment'
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'EmptyStatementFormatter', EmptyStatementFormatter.new, StackTrace.current);
}
