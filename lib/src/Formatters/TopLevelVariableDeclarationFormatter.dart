import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class TopLevelVariableDeclarationFormatter extends TypedFormatter<TopLevelVariableDeclaration>
{
    TopLevelVariableDeclarationFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(TopLevelVariableDeclaration node)
    {
        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        formatState.copyEntity(node.augmentKeyword, astVisitor, '$methodName/node.augmentKeyword');
        formatState.copyEntity(node.externalKeyword, astVisitor, '$methodName/node.externalKeyword');
        formatState.copyEntity(node.variables, astVisitor, '$methodName/node.variables');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon', config.space0);
    }
}
