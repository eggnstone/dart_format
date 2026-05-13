import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/SwitchDefaultFormatter.dart';

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
            inputNodeCreator: AstCreator.createSwitchStatementMemberInFunction,
            inputLeading: 'void f(){switch(i){',
            inputMiddle:
                'default:\n'
                ';\n'
                ';',
            inputTrailing: '}}',
            name: 'SwitchDefault',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<EmptyStatement>(28, ';'),
                TestVisitor<EmptyStatement>(30, ';')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig(
                    'default:\n'
                    '    ;\n'
                    '    ;'
                )
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'SwitchDefaultFormatter', SwitchDefaultFormatter.new, StackTrace.current);
}
