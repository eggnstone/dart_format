import 'package:dart_format/src/Formatters/SimpleStringLiteralFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestConfig.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createInitializerInTopLevelVariable,
            inputLeading: 'var s=\n',
            inputMiddle: "'''abc\nxyz'''",
            inputTrailing: ';\n',
            name: "SimpleStringLiteral triple ' no indents"
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createInitializerInTopLevelVariable,
            inputLeading: 'var s=\n',
            inputMiddle: "    '''abc\n    xyz'''",
            inputTrailing: ';\n',
            name: "SimpleStringLiteral triple ' first indent removed, second indent preserved",
            testConfigs: <TestConfig>[
                TestConfig.none("'''abc\n    xyz'''"),
                TestConfig("'''abc\n    xyz'''")
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createInitializerInTopLevelVariable,
            inputLeading: 'var s=\n',
            inputMiddle: "    r'''abc\n    xyz'''",
            inputTrailing: ';\n',
            name: "SimpleStringLiteral raw triple ' first indent removed, second indent preserved",
            testConfigs: <TestConfig>[
                TestConfig.none("r'''abc\n    xyz'''"),
                TestConfig("r'''abc\n    xyz'''")
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createInitializerInTopLevelVariable,
            inputLeading: 'var s=\n',
            inputMiddle: '    """abc\n    xyz"""',
            inputTrailing: ';\n',
            name: 'SimpleStringLiteral triple " first indent removed, second indent preserved',
            testConfigs: <TestConfig>[
                TestConfig.none('"""abc\n    xyz"""'),
                TestConfig('"""abc\n    xyz"""')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createInitializerInTopLevelVariable,
            inputLeading: 'var s=\n',
            inputMiddle: '    r"""abc\n    xyz"""',
            inputTrailing: ';\n',
            name: 'SimpleStringLiteral raw triple " first indent removed, second indent preserved',
            testConfigs: <TestConfig>[
                TestConfig.none('r"""abc\n    xyz"""'),
                TestConfig('r"""abc\n    xyz"""')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'SimpleStringLiteralFormatter', SimpleStringLiteralFormatter.new, StackTrace.current);
}
