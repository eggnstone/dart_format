import 'package:analyzer/dart/ast/ast.dart';

import 'TestConfig.dart';
import 'Visitors/TestVisitor.dart';

typedef CreateInputNodeFunction = AstNode Function(String s);

class TestGroupConfig
{
    final CreateInputNodeFunction inputNodeCreator;
    final String inputLeading;
    final String inputMiddle;
    final String inputTrailing;
    final String? name;
    final List<TestConfig>? testConfigs;
    final List<TestVisitor<AstNode>>? astVisitors;

    TestGroupConfig({
        required this.inputMiddle,
        required this.inputNodeCreator,
        this.name,
        String? inputLeading,
        String? inputTrailing,
        this.testConfigs,
        List<TestVisitor<AstNode>>? astVisitors
    }) 
        : astVisitors = _setIndices(astVisitors),
        inputLeading = inputLeading ?? '',
        inputTrailing = inputTrailing ?? '';

    AstNode getInputNode()
    => inputNodeCreator('$inputLeading$inputMiddle$inputTrailing');

    static List<TestVisitor<AstNode>>? _setIndices(List<TestVisitor<AstNode>>? astVisitors)
    {
        if (astVisitors == null)
            return null;

        for (int i = 0; i < astVisitors.length; i++)
            astVisitors[i].index = i;

        return astVisitors;
    }
}
