import 'package:dart_format/src/Formatters/FieldFormalParameterFormatter.dart';

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
            inputNodeCreator: AstCreator.createFunctionDefaultFormalParameterParameter,
            inputLeading: 'void f({',
            inputMiddle: 'required  this  .  x',
            inputTrailing: '}){}',
            name: 'required this.x (too much spacing)', // TODO: too little spacing
            astVisitors: <TestVisitor<void>>[
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('required this.x')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'FieldFormalParameterFormatter', FieldFormalParameterFormatter.new, StackTrace.current);
}
