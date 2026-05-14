import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/RecordTypeAnnotationNamedFieldsFormatter.dart';

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
            inputNodeCreator: AstCreator.createRecordTypeAnnotationNamedFieldsInVariable,
            inputLeading: 'void f(){(int,',
            inputMiddle: '{int b}',
            inputTrailing: ') r;}',
            name: 'RecordTypeAnnotationNamedFields',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<RecordTypeAnnotationNamedField>(15, 'int b')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('{int b}')
            ]
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createRecordTypeAnnotationNamedFieldsInVariable,
            inputLeading: 'void f(){(int,',
            inputMiddle: '{\nint b,\nint c\n}',
            inputTrailing: ') r;}',
            name: 'RecordTypeAnnotationNamedFields multi-line indents body and keeps closing } at outer level',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<RecordTypeAnnotationNamedField>(16, 'int b'),
                TestVisitor<RecordTypeAnnotationNamedField>(23, 'int c')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig(
                    '{\n'
                    '    int b,\n'
                    '    int c\n'
                    '}'
                )
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'RecordTypeAnnotationNamedFieldsFormatter', RecordTypeAnnotationNamedFieldsFormatter.new, StackTrace.current);
}
