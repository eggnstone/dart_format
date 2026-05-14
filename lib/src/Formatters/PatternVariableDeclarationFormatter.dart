import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class PatternVariableDeclarationFormatter extends TypedFormatter<PatternVariableDeclaration>
{
    PatternVariableDeclarationFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(PatternVariableDeclaration node)
    {
        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        formatState.copyEntity(node.keyword, astVisitor, '$methodName/node.keyword');
        formatState.copyEntity(node.pattern, astVisitor, '$methodName/node.pattern', config.space1);
        formatState.copyEntity(node.equals, astVisitor, '$methodName/node.equals', config.space1);
        formatState.copyEntity(node.expression, astVisitor, '$methodName/node.expression', config.space1);
    }
}
