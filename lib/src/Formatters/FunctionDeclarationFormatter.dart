import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class FunctionDeclarationFormatter extends TypedFormatter<FunctionDeclaration>
{
    FunctionDeclarationFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(FunctionDeclaration node)
    {
        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        copyZeroOne(node, node.augmentKeyword, '$methodName/node.augmentKeyword');
        copyZeroOne(node, node.externalKeyword, '$methodName/node.externalKeyword');
        copyZeroOne(node, node.returnType, '$methodName/node.returnType');
        copyZeroOne(node, node.propertyKeyword, '$methodName/node.propertyKeyword');
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name', config.space1);

        //logWarning('S functionExpression');
        formatState.copyEntity(node.functionExpression, astVisitor, '$methodName/node.functionExpression');
        //logWarning('E functionExpression');
    }
}
