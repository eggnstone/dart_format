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
        copyZeroOne(node, node.augmentKeyword, '$methodName/node.augmentKeyword');
        copyZeroOne(node, node.externalKeyword, '$methodName/node.externalKeyword');
        copyZeroOne(node, node.variables, '$methodName/node.variables');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon', config.space0);
    }
}
