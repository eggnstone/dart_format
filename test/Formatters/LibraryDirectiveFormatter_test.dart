import 'package:dart_format/src/Formatters/DirectiveFormatters/LibraryDirectiveFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestConfig.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestAstVisitor.dart';
import '../TestTools/Visitors/TestLibraryIdentifierVisitor.dart';

void main()
{
    TestTools.init();

    // TODO: move line break tests to separate test file
    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createDirective,
            inputMiddle: 'library l;',
            name: 'End of text',
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('library l;\n')
            ],
            astVisitors: <TestAstVisitor>[
                TestLibraryIdentifierVisitor(8, 'l')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createDirective,
            inputMiddle: 'library l;',
            inputTrailing: '//Comment\n',
            name: 'End of text with comment',
            astVisitors: <TestAstVisitor>[
              TestLibraryIdentifierVisitor(8, 'l')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createDirective,
            inputMiddle: 'library l;',
            inputTrailing: '//Comment',
            name: 'End of text with comment but no NewLine',
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('library l;//Comment\n', '')
            ],
            astVisitors: <TestAstVisitor>[
              TestLibraryIdentifierVisitor(8, 'l')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'LibraryDirectiveFormatter', LibraryDirectiveFormatter.new, StackTrace.current);
}
