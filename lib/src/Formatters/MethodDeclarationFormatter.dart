import 'package:analyzer/dart/ast/ast.dart';

import '../Copier.dart';
import '../Types/Spacing.dart';
import 'TypedFormatter.dart';

class MethodDeclarationFormatter extends TypedFormatter<MethodDeclaration>
{
    MethodDeclarationFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(MethodDeclaration node)
    {
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
        copier.copyNullableEntity(node.augmentKeyword, '$methodName/node.augmentKeyword', Spacing.zeroOne);
        copier.copyNullableEntity(node.externalKeyword, '$methodName/node.externalKeyword', Spacing.zeroOne);
        copier.copyNullableEntity(node.modifierKeyword, '$methodName/node.modifierKeyword', Spacing.zeroOne);
        copier.copyNullableEntity(node.returnType, '$methodName/node.returnType', Spacing.zeroOne);
        copier.copyNullableEntity(node.propertyKeyword, '$methodName/node.propertyKeyword', Spacing.zeroOne);
        copier.copyNullableEntity(node.operatorKeyword, '$methodName/node.operatorKeyword', Spacing.zeroOne);

        final int? spacesForName = config.fixSpaces ? (node.offset == node.name.offset ? 0 : node.operatorKeyword == null ? 1 : 0) : null;
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name', spacesForName);

        copier.copyNullableEntity(node.typeParameters, '$methodName/node.typeParameters', Spacing.zero);
        copier.copyNullableEntity(node.parameters, '$methodName/node.parameters', Spacing.zero);
        copier.copyEntity(node.body, '$methodName/node.body', Spacing.emptyFunctionBodyZeroOne);
    }
}
