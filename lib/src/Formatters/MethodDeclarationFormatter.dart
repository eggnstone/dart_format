// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../Data/ConfigExtension.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
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
        logError('MethodDeclaration');
        formatState.dump(node, 'node');
        formatState.dumpList(node.sortedCommentAndAnnotations, 'sortedCommentAndAnnotations');
        formatState.dump(node.modifierKeyword, 'modifierKeyword');
        formatState.dump(node.returnType, 'returnType');
        formatState.dump(node.propertyKeyword, 'propertyKeyword');
        formatState.dump(node.name, 'name');
        formatState.dump(node.typeParameters, 'typeParameters');
        formatState.dump(node.parameters, 'parameters');
        formatState.dump(node.body, 'body');
        */

        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');

        if (node.modifierKeyword != null)
        {
            final int? spacesForModifierKeyword = config.fixSpaces ? (node.offset == node.modifierKeyword!.offset ? 0 : 1) : null;
            formatState.copyEntity(node.modifierKeyword, astVisitor, '$methodName/node.modifierKeyword', spacesForModifierKeyword);
        }

        if (node.returnType != null)
        {
            final int? spacesForReturnType = config.fixSpaces ? (node.offset == node.returnType!.offset ? 0 : 1) : null;
            formatState.copyEntity(node.returnType, astVisitor, '$methodName/node.returnType', spacesForReturnType);
        }

        if (node.propertyKeyword != null)
        {
            final int? spacesForPropertyKeyword = config.fixSpaces ? (node.offset == node.propertyKeyword!.offset ? 0 : 1) : null;
            formatState.copyEntity(node.propertyKeyword, astVisitor, '$methodName/node.propertyKeyword', spacesForPropertyKeyword);
        }

        final int? spacesForName = config.fixSpaces ? (node.offset == node.name.offset ? 0 : 1) : null;
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name', spacesForName);

        formatState.copyEntity(node.typeParameters, astVisitor, '$methodName/node.typeParameters', config.space0);
        formatState.copyEntity(node.parameters, astVisitor, '$methodName/node.parameters', config.space0);

        //formatState.consumeSpacesBeforeFunctionBody(node.body, config);
        final int? spacesForBody = config.fixSpaces ? (node.body is EmptyFunctionBody ? 0 : 1) : null;
        formatState.copyEntity(node.body, astVisitor, '$methodName/node.body', spacesForBody);
        //formatState.copyEntity(node.body, astVisitor, '$methodName/node.body');

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
