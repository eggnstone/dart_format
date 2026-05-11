import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/FieldDeclarationFormatter.dart';

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
            inputNodeCreator: AstCreator.createFieldDeclarationInClass,
            inputLeading: 'class C{',
            inputMiddle: '@a late final int i;',
            inputTrailing: '}',
            name: 'FieldDeclaration @a late final int i;',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<Annotation>(8, '@a'),
                TestVisitor<VariableDeclarationList>(11, 'late final int i')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('@a late final int i;\n')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFieldDeclarationInClass,
            inputLeading: 'abstract class C{',
            inputMiddle: 'abstract bool b;',
            inputTrailing: '}',
            name: 'FieldDeclaration abstract field in abstract class',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<VariableDeclarationList>(26, 'bool b')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('abstract bool b;\n')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFieldDeclarationInClass,
            inputLeading: 'class C{',
            inputMiddle: 'covariant int i=0;',
            inputTrailing: '}',
            name: 'FieldDeclaration with covariant',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<VariableDeclarationList>(18, 'int i=0')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('covariant int i=0;\n')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createFieldDeclarationInClassWithAugmentations,
            inputLeading: 'class C{',
            inputMiddle: 'augment int i=0;',
            inputTrailing: '}',
            name: 'FieldDeclaration with augment',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<VariableDeclarationList>(16, 'int i=0')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('augment int i=0;\n')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'FieldDeclarationFormatter', FieldDeclarationFormatter.new, StackTrace.current);
}
