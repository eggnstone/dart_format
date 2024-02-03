import 'package:dart_format/src/Formatters/GenericFunctionTypeFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestAstVisitor.dart';
import '../TestTools/Visitors/TestFormalParameterListVisitor.dart';
import '../TestTools/Visitors/TestNamedTypeVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createTypeAnnotationInFunctionParameter,
            inputLeading: 'void f(',
            inputMiddle: 'void Function()',
            inputTrailing: 'g){}',
            name: 'TODO',
            astVisitors: <TestAstVisitor>[
                TestNamedTypeVisitor(7, 'void'),
                TestFormalParameterListVisitor(20, '()')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'GenericFunctionTypeFormatter', GenericFunctionTypeFormatter.new, StackTrace.current);
}
