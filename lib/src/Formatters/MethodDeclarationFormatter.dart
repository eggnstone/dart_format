import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class MethodDeclarationFormatter extends TypedFormatter<MethodDeclaration>
{
    MethodDeclarationFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(MethodDeclaration node)
    {
        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        copyZeroOne(node, node.augmentKeyword, '$methodName/node.augmentKeyword');
        copyZeroOne(node, node.externalKeyword, '$methodName/node.externalKeyword');
        copyZeroOne(node, node.modifierKeyword, '$methodName/node.modifierKeyword');
        copyZeroOne(node, node.returnType, '$methodName/node.returnType');
        copyZeroOne(node, node.propertyKeyword, '$methodName/node.propertyKeyword');
        copyZeroOne(node, node.operatorKeyword, '$methodName/node.operatorKeyword');

        final int? spacesForName = config.fixSpaces ? (node.offset == node.name.offset ? 0 : node.operatorKeyword == null ? 1 : 0) : null;
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name', spacesForName);

        formatState.copyEntity(node.typeParameters, astVisitor, '$methodName/node.typeParameters', config.space0);
        formatState.copyEntity(node.parameters, astVisitor, '$methodName/node.parameters', config.space0);
        formatState.copyEntity(node.body, astVisitor, '$methodName/node.body', config.getSpacesEmptyFunctionBodyZeroOne(node.body));
    }
}
