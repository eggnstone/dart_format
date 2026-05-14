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
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'RecordTypeAnnotationNamedFieldsFormatter', RecordTypeAnnotationNamedFieldsFormatter.new, StackTrace.current);
}
