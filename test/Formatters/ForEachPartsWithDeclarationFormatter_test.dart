import 'package:dart_format/src/Formatters/DeclarationFormatters/ForEachPartsWithDeclarationFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestAstVisitor.dart';
import '../TestTools/Visitors/TestDeclaredIdentifierVisitor.dart';
import '../TestTools/Visitors/TestSimpleIdentifierVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createForLoopPartsInForStatementInFunction,
            inputLeading: 'void f(){for(',
            //inputMiddle: 'i in l', TODO: ForEachPartsWithIdentifier
            inputMiddle: 'int i in l',
            inputTrailing: ');}',
            name: 'ForEachPartsWithDeclaration',
            astVisitors: <TestAstVisitor>[
                TestDeclaredIdentifierVisitor(13, 'int i'),
                TestSimpleIdentifierVisitor(22, 'l')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'ForEachPartsWithDeclarationFormatter', ForEachPartsWithDeclarationFormatter.new, StackTrace.current);
}
