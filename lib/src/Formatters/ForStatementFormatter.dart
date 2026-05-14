import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class ForStatementFormatter extends TypedFormatter<ForStatement>
{
    ForStatementFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(ForStatement node)
    {
        final int? spacesForForKeyword = config.fixSpaces ? (node.offset == node.forKeyword.offset ? null : 1) : null;

        formatState.copyEntity(node.awaitKeyword, astVisitor, '$methodName/node.awaitKeyword');
        formatState.copyEntity(node.forKeyword, astVisitor, '$methodName/node.forKeyword', spacesForForKeyword);
        formatState.copyEntity(node.leftParenthesis, astVisitor, '$methodName/node.leftParenthesis', config.space1);
        formatState.copyEntity(node.forLoopParts, astVisitor, '$methodName/node.forLoopParts', config.space0);
        formatState.copyEntity(node.rightParenthesis, astVisitor, '$methodName/node.rightParenthesis', config.space0);
        formatState.pushLevel('$methodName/node.body');
        formatState.copyEntity(node.body, astVisitor, '$methodName/node.body');
        formatState.popLevelAndIndent();
    }
}
