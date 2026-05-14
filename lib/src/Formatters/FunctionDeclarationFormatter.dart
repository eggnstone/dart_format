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
        formatState.copyEntity(node.augmentKeyword, astVisitor, '$methodName/node.augmentKeyword');
        formatState.copyEntity(node.externalKeyword, astVisitor, '$methodName/node.externalKeyword');
        formatState.copyEntity(node.returnType, astVisitor, '$methodName/node.returnType');
        formatState.copyEntity(node.propertyKeyword, astVisitor, '$methodName/node.propertyKeyword');
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name', config.space1);

        //logWarning('S functionExpression');
        formatState.copyEntity(node.functionExpression, astVisitor, '$methodName/node.functionExpression');
        //logWarning('E functionExpression');
    }
}
