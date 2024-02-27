import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/LibraryDirectiveFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestConfig.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestVisitor.dart';

void main()
{
    TestTools.init();

    // TODO: move line break tests to separate test file
    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createDirective,
            inputMiddle: 'library l;',
            name: 'End of text',
            astVisitors: <TestVisitor<AstNode>>[
                TestVisitor<LibraryIdentifier>(8, 'l')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('library l;\n')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createDirective,
            inputMiddle: 'library l;',
            inputTrailing: '//Comment\n',
            name: 'End of text with comment',
            astVisitors: <TestVisitor<AstNode>>[
                TestVisitor<LibraryIdentifier>(8, 'l')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createDirective,
            inputMiddle: 'library l;',
            inputTrailing: '//Comment',
            name: 'End of text with comment but no NewLine',
            astVisitors: <TestVisitor<AstNode>>[
                TestVisitor<LibraryIdentifier>(8, 'l')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('library l;//Comment\n', '')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'LibraryDirectiveFormatter', LibraryDirectiveFormatter.new, StackTrace.current);
}
