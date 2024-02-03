import 'package:dart_format/src/Formatters/NamedTypeFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestAstVisitor.dart';
import '../TestTools/Visitors/TestTypeArgumentListVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createNamedTypeOfTopLevelVariable,
            inputLeading: '',
            inputMiddle: 'int',
            inputTrailing: ' i;',
            name: 'int'
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createNamedTypeOfTopLevelVariable,
            inputLeading: '',
            inputMiddle: 'Future<void>',
            inputTrailing: ' f;',
            name: 'Future<void>',
            astVisitors: <TestAstVisitor>[
                TestTypeArgumentListVisitor(6, '<void>')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'NamedTypeFormatter', NamedTypeFormatter.new, StackTrace.current);
}
