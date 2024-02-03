import 'package:dart_format/src/Formatters/DeclarationFormatters/EnumConstantDeclarationFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestAnnotationVisitor.dart';
import '../TestTools/Visitors/TestAstVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createEnumConstantDeclaration,
            inputLeading: 'enum E{',
            inputMiddle: '@a x',
            inputTrailing: '}',
            name: 'EnumConstantDeclaration',
            astVisitors: <TestAstVisitor>[TestAnnotationVisitor(7, '@a')]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'EnumConstantDeclarationFormatter', EnumConstantDeclarationFormatter.new, StackTrace.current);
}
