import 'package:dart_format/src/Formatters/SymbolLiteralFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestConfig.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createSymbolLiteralInVariable,
            inputLeading: 'void g(){var s = ',
            inputMiddle: '#a',
            inputTrailing: ';}',
            name: 'SymbolLiteral single component',
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('#a')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createSymbolLiteralInVariable,
            inputLeading: 'void g(){var s = ',
            inputMiddle: '#a.b',
            inputTrailing: ';}',
            name: 'SymbolLiteral dotted',
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('#a.b')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'SymbolLiteralFormatter', SymbolLiteralFormatter.new, StackTrace.current);
}
