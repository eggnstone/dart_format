import 'package:analyzer/dart/ast/ast.dart';

import '../../Config.dart';
import '../../Constants.dart';
import '../../FormatState.dart';
import '../../Tools/StringTools.dart';
import '../../Types/IndentationType.dart';
import '../IFormatter.dart';

class ConstructorDeclarationFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ConstructorDeclarationFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ConstructorDeclarationFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! ConstructorDeclaration)
            throw FormatException('Not a ConstructorDeclaration: ${node.runtimeType}');

        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        formatState.copyEntity(node.constKeyword, astVisitor, '$methodName/node.constKeyword'); // covered by tests
        formatState.copyEntity(node.factoryKeyword, astVisitor, '$methodName/node.factoryKeyword'); // covered by tests
        formatState.copyEntity(node.returnType, astVisitor, '$methodName/node.returnType'); // covered by tests
        formatState.copyEntity(node.period, astVisitor, '$methodName/node.period'); // covered by tests
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name'); // covered by tests
        formatState.copyEntity(node.parameters, astVisitor, '$methodName/node.parameters'); // covered by tests
        formatState.pushLevel('$methodName/node.statements', IndentationType.multiple); // covered by tests
        formatState.copyEntity(node.separator, astVisitor, '$methodName/node.separator'); // covered by tests
        formatState.copyEntity(node.redirectedConstructor, astVisitor, '$methodName/node.redirectedConstructor'); // covered by tests
        formatState.acceptListWithComma(node.initializers, null, astVisitor, '$methodName/node.initializers');
        formatState.popLevelAndIndent(); // covered by tests
        formatState.copyEntity(node.body, astVisitor, '$methodName/node.body');
    }
}
