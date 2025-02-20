import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/ExpressionFunctionBodyFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestConfig.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        // old
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFunctionBody,
            inputLeading: 'void f()  ',
            inputMiddle: '=>  null  ;',
            inputTrailing: '',
            name: 'ExpressionFunctionBody / => null;',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NullLiteral>(14, 'null'),
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('=> null;\n')
            ]
        ),
        /*TODO
        // new
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFunctionBody,
            inputLeading: 'void f()  ',
            inputMiddle: '/*x*/  =>  null  ;',
            inputTrailing: '',
            name: 'ExpressionFunctionBody / /*x*/ => null;',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NullLiteral>(14, 'null'),
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('=> null;\n')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFunctionBody,
            inputLeading: 'void f()  ',
            inputMiddle: '/**/  =>  null  ;',
            inputTrailing: '',
            name: 'ExpressionFunctionBody',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NullLiteral>(14, 'null')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('=> null;\n')
            ]
        )
        */
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'ExpressionFunctionBodyFormatter', ExpressionFunctionBodyFormatter.new, StackTrace.current);
}
