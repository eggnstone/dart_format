import 'package:dart_format/src/Formatters/DeclarationFormatters/ConstructorDeclarationFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestConfig.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestAnnotationVisitor.dart';
import '../TestTools/Visitors/TestAstVisitor.dart';
import '../TestTools/Visitors/TestBlockFunctionBodyVisitor.dart';
import '../TestTools/Visitors/TestConstructorFieldInitializerVisitor.dart';
import '../TestTools/Visitors/TestConstructorNameVisitor.dart';
import '../TestTools/Visitors/TestEmptyFunctionBodyVisitor.dart';
import '../TestTools/Visitors/TestFormalParameterListVisitor.dart';
import '../TestTools/Visitors/TestSimpleIdentifierVisitor.dart';
import '../TestTools/Visitors/TestSuperConstructorInvocationVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createClassMember,
            inputLeading: 'class C{',
            inputMiddle: 'const C();',
            inputTrailing: '}',
            name: 'const / no params',
            astVisitors: <TestAstVisitor>[
                TestSimpleIdentifierVisitor(14, 'C'),
                TestFormalParameterListVisitor(15, '()'),
                TestEmptyFunctionBodyVisitor(17, ';')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createClassMember,
            inputLeading: 'class C{',
            inputMiddle: 'const C(int i);',
            inputTrailing: '}',
            name: 'const / 1 param',
            astVisitors: <TestAstVisitor>[
                TestSimpleIdentifierVisitor(14, 'C'),
                TestFormalParameterListVisitor(15, '(int i)'),
                TestEmptyFunctionBodyVisitor(22, ';')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createClassMember,
            inputLeading: 'class C{',
            inputMiddle: 'const C({int i});',
            inputTrailing: '}',
            name: 'const / 1 named param',
            astVisitors: <TestAstVisitor>[
                TestSimpleIdentifierVisitor(14, 'C'),
                TestFormalParameterListVisitor(15, '({int i})'),
                TestEmptyFunctionBodyVisitor(24, ';')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createClassMember,
            inputLeading: 'class C{',
            inputMiddle: '@a factory C(){}',
            inputTrailing: '}',
            name: 'With annotated factory with class name only',
            astVisitors: <TestAstVisitor>[
                TestAnnotationVisitor(8, '@a'),
                TestSimpleIdentifierVisitor(19, 'C'),                
                TestFormalParameterListVisitor(20, '()'),
                TestBlockFunctionBodyVisitor(22, '{}')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createClassMember,
            inputLeading:  'class C{',
            inputMiddle: 'factory C.f(){}',
            inputTrailing: '}',
            name: 'With factory with class+factory name',
            astVisitors: <TestAstVisitor>[
                TestSimpleIdentifierVisitor(16, 'C'),
                TestFormalParameterListVisitor(19, '()'),
                TestBlockFunctionBodyVisitor(21, '{}')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createClassMember,
            inputLeading: 'class C{',
            inputMiddle: 'const factory C()=_C;',
            inputTrailing: '}',
            name: 'With factory with redirect',
            astVisitors: <TestAstVisitor>[
                TestSimpleIdentifierVisitor(22, 'C'),
                TestFormalParameterListVisitor(23, '()'),
                TestConstructorNameVisitor(26, '_C'),
                TestEmptyFunctionBodyVisitor(28, ';')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createClassMember,
            inputLeading: 'class C{',
            inputMiddle:  'C():super(){}',
            inputTrailing: '}',
            name: 'With super',
            astVisitors: <TestAstVisitor>[
                TestSimpleIdentifierVisitor(8, 'C'),
                TestFormalParameterListVisitor(9, '()'),
                TestSuperConstructorInvocationVisitor(12, 'super()'),
                TestBlockFunctionBodyVisitor(19, '{}')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createClassMember,
            inputLeading: 'class C{',
            inputMiddle:  'const C():super();',
            inputTrailing: '}',
            name: 'Const with super',
            astVisitors: <TestAstVisitor>[
                TestSimpleIdentifierVisitor(14, 'C'),
                TestFormalParameterListVisitor(15, '()'),
                TestSuperConstructorInvocationVisitor(18, 'super()'),
                TestEmptyFunctionBodyVisitor(25, ';')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createClassMember,
            inputLeading: 'class C{',
            inputMiddle: 'const C():a=0,b=0;',
            inputTrailing: '}',
            name: 'With initializers (1 line)',
            astVisitors: <TestAstVisitor>[
                TestSimpleIdentifierVisitor(14, 'C'),
                TestFormalParameterListVisitor(15, '()'),
                TestConstructorFieldInitializerVisitor(18, 'a=0'),
                TestConstructorFieldInitializerVisitor(22, 'b=0'),
                TestEmptyFunctionBodyVisitor(25, ';')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createClassMember,
            inputLeading: 'class C{',
            inputMiddle: 'const C()\n:a=0,b=0;',
            inputTrailing: '}',
            name: 'With initializers (2 lines)',
            astVisitors: <TestAstVisitor>[
                TestSimpleIdentifierVisitor(14, 'C'),
                TestFormalParameterListVisitor(15, '()'),
                TestConstructorFieldInitializerVisitor(19, 'a=0'),
                TestConstructorFieldInitializerVisitor(23, 'b=0'),
                TestEmptyFunctionBodyVisitor(26, ';')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('const C()\n    :a=0,b=0;')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createClassMember,
            inputLeading: 'class C{',
            inputMiddle: 'const C()\n:a=0,\nb=0;',
            inputTrailing: '}',
            name: 'With initializers (3 lines)',
            astVisitors: <TestAstVisitor>[
                TestSimpleIdentifierVisitor(14, 'C'),
                TestFormalParameterListVisitor(15, '()'),
                TestConstructorFieldInitializerVisitor(19, 'a=0'),
                TestConstructorFieldInitializerVisitor(24, 'b=0'),
                TestEmptyFunctionBodyVisitor(27, ';')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('const C()\n    :a=0,\n    b=0;')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'ConstructorDeclarationFormatter', ConstructorDeclarationFormatter.new, StackTrace.current);
}
