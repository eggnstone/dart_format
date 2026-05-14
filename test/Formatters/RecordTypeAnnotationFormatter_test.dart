import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/RecordTypeAnnotationFormatter.dart';

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
            inputNodeCreator: AstCreator.createFirstTypeArgumentInMethodReturnType,
            inputLeading: 'class C{Future<',
            inputMiddle: '({int a,int b})',
            inputTrailing: '> c(){}}',
            name: 'RecordTypeAnnotation as type argument: Future<({int a, int b})>',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<RecordTypeAnnotationNamedFields>(16, '{int a,int b}')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('({int a,int b})')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createMethodReturnType,
            inputLeading: 'class C{static ',
            inputMiddle: '({int a,int b})',
            inputTrailing: ' c(){}}',
            name: 'RecordTypeAnnotation as static method return type: static ({int a, int b}) c()',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<RecordTypeAnnotationNamedFields>(16, '{int a,int b}')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('({int a,int b})')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createMethodReturnType,
            inputLeading: 'class C{static ',
            inputMiddle: '(\nint,\nint\n)',
            inputTrailing: ' c(){}}',
            name: 'RecordTypeAnnotation multi-line positional fields',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<RecordTypeAnnotationPositionalField>(17, 'int'),
                TestVisitor<RecordTypeAnnotationPositionalField>(22, 'int')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig(
                    '(\n'
                    '    int,\n'
                    '    int\n'
                    ')'
                )
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'RecordTypeAnnotationFormatter', RecordTypeAnnotationFormatter.new, StackTrace.current);
}
