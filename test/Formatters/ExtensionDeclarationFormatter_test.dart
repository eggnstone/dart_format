import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Formatters/ExtensionDeclarationFormatter.dart';

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
            inputNodeCreator: AstCreator.createDeclaration,
            inputMiddle: 'extension E<T1,T2> on C<T1,T2>{void m(){}}',
            name: 'ExtensionDeclaration',
            astVisitors: <TestVisitor<void>>[
                TestVisitor<TypeParameterList>(11, '<T1,T2>'),
                //TestVisitor<NamedType>(22, 'C<T1,T2>'), onClause replaces onKeyword and extendedType
                TestVisitor<ExtensionOnClause>(19, 'on C<T1,T2>'),
                TestVisitor<MethodDeclaration>(31, 'void m(){}')
            ],
            testConfigs: <TestConfig>[
                TestConfig.none(),
                TestConfig('extension E<T1,T2> on C<T1,T2>\n{\n    void m(){}\n}\n')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'ExtensionDeclarationFormatter', ExtensionDeclarationFormatter.new, StackTrace.current);
}
