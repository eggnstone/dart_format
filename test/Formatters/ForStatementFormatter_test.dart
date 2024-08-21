import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/ForStatementFormatter.dart';

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
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'for(;;);',
            inputTrailing: '}',
            name: 'ForStatement for(;;);',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<ForPartsWithExpression>(13, ';;'),
                TestVisitor<EmptyStatement>(16, ';')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f(){',
            inputMiddle: 'for(;;)\n;',
            inputTrailing: '}',
            name: r'ForStatement for(;;)\n;',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<ForPartsWithExpression>(13, ';;'),
                TestVisitor<EmptyStatement>(17, ';')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('for(;;)\n    ;')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createStatementInFunction,
            inputLeading: 'void f()async{',
            inputMiddle: 'await for(a in b);',
            inputTrailing: '}',
            name: 'ForStatement await for(a in b);',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<ForEachPartsWithIdentifier>(24, 'a in b'),
                TestVisitor<EmptyStatement>(31, ';')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'ForStatementFormatter', ForStatementFormatter.new, StackTrace.current);
}
