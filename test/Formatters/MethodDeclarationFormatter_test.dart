import 'package:dart_format/src/Formatters/DeclarationFormatters/MethodDeclarationFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestAnnotationVisitor.dart';
import '../TestTools/Visitors/TestAstVisitor.dart';
import '../TestTools/Visitors/TestBlockFunctionBodyVisitor.dart';
import '../TestTools/Visitors/TestExpressionFunctionBodyVisitor.dart';
import '../TestTools/Visitors/TestFormalParameterListVisitor.dart';
import '../TestTools/Visitors/TestNamedTypeVisitor.dart';
import '../TestTools/Visitors/TestTypeParameterListVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        // TODO: async is not part of MethodDeclaration => remove it
        TestGroupConfig(
            inputNodeCreator: AstCreator.createClassMember,
            inputLeading: 'class C{',
            inputMiddle: '@a static void m<T>()async{}',
            inputTrailing: '}',
            name: '@a static void m<T>() async{}',
            astVisitors: <TestAstVisitor>[
                TestAnnotationVisitor(8, '@a'),
                TestNamedTypeVisitor(18, 'void'),
                TestTypeParameterListVisitor(24, '<T>'),
                TestFormalParameterListVisitor(27, '()'),
                TestBlockFunctionBodyVisitor(29, 'async{}')
            ]
        ),
        // TODO: async is not part of MethodDeclaration => remove it
        // TODO: Why is /*Comment8*/ part of the MethodDeclaration?
        TestGroupConfig(
            inputNodeCreator: AstCreator.createClassMember,
            inputLeading: 'class C{',
            inputMiddle: '/*Comment1*/@a/*Comment2*/static/*Comment3*/void/*Comment4*/m/*Comment5*/<T>/*Comment6*/(/*Comment7*/)/*Comment8*/async/*Comment9*/{/*Comment10*/}',
            inputTrailing: '}',
            name: '@a static void m<T>() async{} (with comments)',
            astVisitors: <TestAstVisitor>[
                TestAnnotationVisitor(8, '/*Comment1*/@a'),
                TestNamedTypeVisitor(52, 'void'),
                TestTypeParameterListVisitor(81, '<T>'),
                TestFormalParameterListVisitor(96, '(/*Comment7*/)'),
                TestBlockFunctionBodyVisitor(122, 'async/*Comment9*/{/*Comment10*/}')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createClassMember,
            inputLeading: 'class C{',
            inputMiddle: '@a int get i=>0;',
            inputTrailing: '}',
            name: '@a int get i=>0;',
            astVisitors: <TestAstVisitor>[
                TestAnnotationVisitor(8, '@a'),
                TestNamedTypeVisitor(11, 'int'),
                TestExpressionFunctionBodyVisitor(20, '=>0;')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'MethodDeclarationFormatter', MethodDeclarationFormatter.new, StackTrace.current);
}
