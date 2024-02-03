import 'package:dart_format/src/Formatters/CommentFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createCommentBeforeClassDeclaration,
            inputMiddle: '/**Comment\nA*/',
            inputTrailing: 'class C{}',
            name: 'Doc block comment before class'
        ),
        /*TestGroupConfig(
        inputNodeCreator: AstCreator.createCommentBeforeClassDeclaration,
        inputMiddle: '/**Comment\n A*/',
        inputTrailing: 'class C{}',
        name: 'Doc block comment before class / formatted'
        )*/

        TestGroupConfig(
            inputNodeCreator: AstCreator.createCommentBeforeClassDeclaration,
            inputMiddle: '/**Comment\nA*/',
            inputTrailing: 'class C{}',
            name: 'Doc block comment before class'
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'CommentFormatter', CommentFormatter.new, StackTrace.current);
}
