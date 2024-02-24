import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/OnClauseFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createOnClauseInMixinDeclaration,
            inputLeading: 'mixin M ',
            inputMiddle: 'on A, B',
            inputTrailing: '{}',
            name: 'OnClause',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<NamedType>(11, 'A'),
                TestVisitor<NamedType>(14, 'B')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'OnClauseFormatter', OnClauseFormatter.new, StackTrace.current);
}
