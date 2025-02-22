// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Copier.dart';
import '../Data/Config.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import '../Types/Spacing.dart';
import 'IFormatter.dart';

class MethodDeclarationFormatter extends IFormatter
{
    static const String CLASS_NAME = 'MethodDeclarationFormatter';

    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    MethodDeclarationFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = '$CLASS_NAME.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! MethodDeclaration)
            throw FormatException('Not a MethodDeclaration: ${node.runtimeType}');

        /*
        formatState.dump(node, 'node');
        formatState.dumpList(node.sortedCommentAndAnnotations, 'sortedCommentAndAnnotations');
        formatState.dump(node.modifierKeyword, 'modifierKeyword');
        formatState.dump(node.returnType, 'returnType');
        formatState.dump(node.propertyKeyword, 'propertyKeyword');
        formatState.dump(node.operatorKeyword, 'operatorKeyword');
        formatState.dump(node.name, 'name');
        formatState.dump(node.typeParameters, 'typeParameters');
        formatState.dump(node.parameters, 'parameters');
        formatState.dump(node.body, 'body');
        */

        final Copier copier = Copier(astVisitor, config, formatState, node);

        copier.acceptList(node.sortedCommentAndAnnotations, '$methodName/node.sortedCommentAndAnnotations');
        copier.copyEntity(node.externalKeyword, '$methodName/node.externalKeyword', Spacing.zeroOne);
        copier.copyEntity(node.modifierKeyword, '$methodName/node.modifierKeyword', Spacing.zeroOne);
        copier.copyEntity(node.returnType, '$methodName/node.returnType', Spacing.zeroOne);
        copier.copyEntity(node.propertyKeyword, '$methodName/node.propertyKeyword', Spacing.zeroOne);
        copier.copyEntity(node.operatorKeyword, '$methodName/node.operatorKeyword', Spacing.zeroOne);

        final int? spacesForName = config.fixSpaces ? (node.offset == node.name.offset ? 0 : node.operatorKeyword == null ? 1 : 0) : null;
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name', spacesForName);

        copier.copyEntity(node.typeParameters, '$methodName/node.typeParameters', Spacing.zero);
        copier.copyEntity(node.parameters, '$methodName/node.parameters', Spacing.zero);
        copier.copyEntity(node.body, '$methodName/node.body', Spacing.emptyFunctionBodyZeroOne);

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
