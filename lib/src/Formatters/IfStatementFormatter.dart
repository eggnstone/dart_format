import 'package:analyzer/dart/ast/ast.dart';

import '../Copier.dart';
import '../Types/Spacing.dart';
import 'TypedFormatter.dart';

class IfStatementFormatter extends TypedFormatter<IfStatement>
{
    IfStatementFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(IfStatement node)
    {
        /*
        formatState.dump(node, 'node');
        formatState.dump(node.expression, 'expression');
        formatState.dump(node.ifKeyword, 'ifKeyword');
        formatState.dump(node.leftParenthesis, 'leftParenthesis');
        formatState.dump(node.caseClause, 'caseClause');
        formatState.dump(node.rightParenthesis, 'rightParenthesis');
        formatState.dump(node.thenStatement, 'thenStatement');
        */

        final Copier copier = Copier(astVisitor, config, formatState, node);

        copier.copyEntity(node.ifKeyword, '$methodName/node.ifKeyword', Spacing.zeroOne);
        copier.copyEntity(node.leftParenthesis, '$methodName/node.leftParenthesis', Spacing.one);
        copier.copyEntity(node.expression, '$methodName/node.expression', Spacing.zero);
        copier.copyNullableEntity(node.caseClause, '$methodName/node.caseClause', Spacing.one);
        copier.copyEntity(node.rightParenthesis, '$methodName/node.rightParenthesis', Spacing.zero);

        formatState.pushLevel('$methodName/node.thenStatement');
        copier.copyEntity(node.thenStatement, '$methodName/node.thenStatement', Spacing.emptyStatementZeroOne);
        formatState.popLevelAndIndent();

        if (node.elseKeyword == null)
            return;

        final bool indentElse = node.elseStatement is! IfStatement;

        copier.copyNullableEntity(node.elseKeyword, '$methodName/node.elseKeyword', Spacing.one);

        if (indentElse)
            formatState.pushLevel('$methodName/node.elseKeyword');

        copier.copyNullableEntity(node.elseStatement, '$methodName/node.elseStatement', Spacing.emptyStatementZeroOne);

        if (indentElse)
            formatState.popLevelAndIndent();
    }
}
