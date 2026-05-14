import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class GenericTypeAliasFormatter extends TypedFormatter<GenericTypeAlias>
{
    GenericTypeAliasFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(GenericTypeAlias node)
    {
        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        formatState.copyEntity(node.augmentKeyword, astVisitor, '$methodName/node.augmentKeyword');
        formatState.copyEntity(node.typedefKeyword, astVisitor, '$methodName/node.typedefKeyword');
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name');
        formatState.copyEntity(node.typeParameters, astVisitor, '$methodName/node.typeParameters');
        formatState.copyEntity(node.equals, astVisitor, '$methodName/node.equals', config.space1);
        formatState.copyEntity(node.type, astVisitor, '$methodName/node.type', config.space1);
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon', config.space0);
    }
}
