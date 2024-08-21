import 'package:analyzer/dart/ast/ast.dart';

import 'TestConfig.dart';

typedef CreateInputNodeFunction = AstNode Function(String s);

class TestGroupConfig
{
    final CreateInputNodeFunction inputNodeCreator;
    final String inputLeading;
    final String inputMiddle;
    final String inputTrailing;
    final String? name;
    final List<TestConfig>? testConfigs;
    final List<AstVisitor<void>>? astVisitors;

    TestGroupConfig({
        required this.inputMiddle,
        required this.inputNodeCreator,
        this.name,
        String? inputLeading,
        String? inputTrailing,
        this.testConfigs,
        this.astVisitors
    }) : inputLeading = inputLeading ?? '', inputTrailing = inputTrailing ?? '';

    AstNode getInputNode()
    => inputNodeCreator('$inputLeading$inputMiddle$inputTrailing');
}
