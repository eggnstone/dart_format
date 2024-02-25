// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

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
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! ConstructorDeclaration)
            throw FormatException('Not a ConstructorDeclaration: ${node.runtimeType}');

        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        formatState.copyEntity(node.externalKeyword, astVisitor, '$methodName/node.externalKeyword');
        formatState.copyEntity(node.constKeyword, astVisitor, '$methodName/node.constKeyword');
        formatState.copyEntity(node.factoryKeyword, astVisitor, '$methodName/node.factoryKeyword');
        formatState.copyEntity(node.returnType, astVisitor, '$methodName/node.returnType');
        formatState.copyEntity(node.period, astVisitor, '$methodName/node.period');
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name');
        formatState.copyEntity(node.parameters, astVisitor, '$methodName/node.parameters');
        formatState.pushLevel('$methodName/node.statements');
        formatState.copyEntity(node.separator, astVisitor, '$methodName/node.separator');
        formatState.copyEntity(node.redirectedConstructor, astVisitor, '$methodName/node.redirectedConstructor');
        formatState.acceptListWithComma(node.initializers, null, astVisitor, '$methodName/node.initializers');
        formatState.popLevelAndIndent();
        formatState.copyEntity(node.body, astVisitor, '$methodName/node.body');

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
