import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/DefaultFormatter.dart';

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
            inputNodeCreator: AstCreator.createCommentBeforeClassDeclaration,
            inputLeading: '',
            inputMiddle: '@a',
            inputTrailing: ' class C{}',
            name: 'DefaultFormatter for Annotation',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<SimpleIdentifier>(1, 'a')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('@a')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'DefaultFormatter', DefaultFormatter.new, StackTrace.current);
}
