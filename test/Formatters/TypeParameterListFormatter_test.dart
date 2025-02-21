import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/TypeParameterListFormatter.dart';

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
            inputNodeCreator: AstCreator.createTypeParameterListInFunction,
            inputLeading: 'void f',
            inputMiddle: '<  A  ,  B  >',
            inputTrailing: '(){}',
            name: 'TypeParameterList <A, B>',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<TypeParameter>(9, 'A'),
                TestVisitor<TypeParameter>(15, 'B'),
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('<A, B>')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'TypeParameterListFormatter', TypeParameterListFormatter.new, StackTrace.current);
}
