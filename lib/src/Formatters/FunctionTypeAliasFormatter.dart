import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class FunctionTypeAliasFormatter extends TypedFormatter<FunctionTypeAlias>
{
    FunctionTypeAliasFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(FunctionTypeAlias node)
    {
        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        formatState.copyEntity(node.augmentKeyword, astVisitor, '$methodName/node.augmentKeyword');
        formatState.copyEntity(node.typedefKeyword, astVisitor, '$methodName/node.typedefKeyword');
        formatState.copyEntity(node.returnType, astVisitor, '$methodName/node.returnType');
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name');
        formatState.copyEntity(node.typeParameters, astVisitor, '$methodName/node.typeParameters');
        formatState.copyEntity(node.parameters, astVisitor, '$methodName/node.parameters');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon', config.space0);
    }
}
