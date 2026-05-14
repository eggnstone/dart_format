import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class IfStatementFormatter extends TypedFormatter<IfStatement>
{
    IfStatementFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(IfStatement node)
    {
        formatState.copyEntity(node.ifKeyword, astVisitor, '$methodName/node.ifKeyword', config.getSpacesZeroOne(node, node.ifKeyword));
        formatState.copyEntity(node.leftParenthesis, astVisitor, '$methodName/node.leftParenthesis', config.space1);
        formatState.copyEntity(node.expression, astVisitor, '$methodName/node.expression', config.space0);
        formatState.copyEntity(node.caseClause, astVisitor, '$methodName/node.caseClause', config.space1);
        formatState.copyEntity(node.rightParenthesis, astVisitor, '$methodName/node.rightParenthesis', config.space0);

        formatState.pushLevel('$methodName/node.thenStatement');
        formatState.copyEntity(node.thenStatement, astVisitor, '$methodName/node.thenStatement', config.getSpacesEmptyStatementZeroOne(node.thenStatement));
        formatState.popLevelAndIndent();

        if (node.elseKeyword == null)
            return;

        final bool indentElse = node.elseStatement is! IfStatement;

        formatState.copyEntity(node.elseKeyword, astVisitor, '$methodName/node.elseKeyword', config.space1);

        if (indentElse)
            formatState.pushLevel('$methodName/node.elseKeyword');

        formatState.copyEntity(node.elseStatement, astVisitor, '$methodName/node.elseStatement', node.elseStatement == null ? null : config.getSpacesEmptyStatementZeroOne(node.elseStatement!));

        if (indentElse)
            formatState.popLevelAndIndent();
    }
}
