/*
import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/StringInterpolationFormatter.dart';

import '../TestTools/AstCreator.dart';
import '../TestTools/TestGroupConfig.dart';
import '../TestTools/TestTools.dart';
import '../TestTools/Visitors/TestVisitor.dart';

void main()
{
    TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createInitializerInTopLevelVariable,
            inputLeading: 'var s=',
            inputMiddle: r"'a$b'",
            inputTrailing: ';',
            name: 'StringInterpolation',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<InterpolationString>(6, "'a"),
                TestVisitor<InterpolationExpression>(8, r'$b'),
                TestVisitor<InterpolationString>(10, "'"),
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'StringInterpolationFormatter', StringInterpolationFormatter.new, StackTrace.current);
}
*/
