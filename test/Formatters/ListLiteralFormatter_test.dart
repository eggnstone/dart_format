import 'package:analyzer/src/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/ListLiteralFormatter.dart';

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
            inputNodeCreator: AstCreator.createInitializerInTopLevelVariable,
            inputLeading: 'var x = ',
            inputMiddle: '<  T  >  [  ]',
            inputTrailing: ';',
            name: 'ListLiteral / <T>[]',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<TypeArgumentList>(8, '<  T  >')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('<  T  >[]')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createInitializerInTopLevelVariable,
            inputLeading: 'var x = ',
            inputMiddle: '<  T  >  [  t  ]',
            inputTrailing: ';',
            name: 'ListLiteral / <T>[t]',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<TypeArgumentList>(8, '<  T  >'),
                TestVisitor<SimpleIdentifier>(20, 't')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('<  T  >[t]')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createInitializerInTopLevelVariable,
            inputLeading: 'var x = ',
            inputMiddle: '<  A  ,  B  >  [  a  ,  b  ]',
            inputTrailing: ';',
            name: 'ListLiteral / <A, B>[a, b]',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<TypeArgumentList>(8, '<  A  ,  B  >'),
                TestVisitor<SimpleIdentifier>(26, 'a'),
                TestVisitor<SimpleIdentifier>(32, 'b')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('<  A  ,  B  >[a, b]')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'ListLiteralFormatter', ListLiteralFormatter.new, StackTrace.current);
}
