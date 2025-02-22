// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Copier.dart';
import '../Data/Config.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import '../Types/Spacing.dart';
import 'IFormatter.dart';

class IfStatementFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    IfStatementFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'IfStatementFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! IfStatement)
            throw FormatException('Not an IfStatement: ${node.runtimeType}');

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

        copier.copyEntity(node.ifKeyword,  '$methodName/node.ifKeyword', Spacing.zeroOne);
        copier.copyEntity(node.leftParenthesis,  '$methodName/node.leftParenthesis', Spacing.one);
        copier.copyEntity(node.expression,  '$methodName/node.expression', Spacing.zero);
        copier.copyEntity(node.caseClause,  '$methodName/node.caseClause', Spacing.one);
        copier.copyEntity(node.rightParenthesis,  '$methodName/node.rightParenthesis', Spacing.zero);

        formatState.pushLevel('$methodName/node.thenStatement');
        copier.copyEntity(node.thenStatement,  '$methodName/node.thenStatement', Spacing.emptyStatementZeroOne);
        formatState.popLevelAndIndent();

        if (node.elseKeyword == null)
            return;

        final bool indentElse = node.elseStatement is! IfStatement;

        copier.copyEntity(node.elseKeyword,  '$methodName/node.elseKeyword', Spacing.one);

        if (indentElse)
            formatState.pushLevel('$methodName/node.elseKeyword');

        copier.copyEntity(node.elseStatement,  '$methodName/node.elseStatement', Spacing.emptyStatementZeroOne);

        if (indentElse)
            formatState.popLevelAndIndent();

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
