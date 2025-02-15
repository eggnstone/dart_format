// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../Data/ConfigExtension.dart';
import '../FormatState.dart';
import '../Tools/LogTools.dart';
import '../Tools/StringTools.dart';
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


        /*formatState.dump(node, 'node');
        formatState.dump(node.ifKeyword, 'ifKeyword');
        formatState.dump(node.leftParenthesis, 'leftParenthesis');
        formatState.dump(node.expression, 'expression');
        formatState.dump(node.caseClause, 'caseClause');
        formatState.dump(node.rightParenthesis, 'rightParenthesis');
        formatState.dump(node.thenStatement, 'thenStatement');*/

        formatState.copyEntity(node.ifKeyword, astVisitor, '$methodName/node.ifKeyword');
        formatState.copyEntity(node.leftParenthesis, astVisitor, '$methodName/node.leftParenthesis', config.space1);
        formatState.copyEntity(node.expression, astVisitor, '$methodName/node.expression');
        formatState.copyEntity(node.caseClause, astVisitor, '$methodName/node.caseClause', config.space1);
        formatState.copyEntity(node.rightParenthesis, astVisitor, '$methodName/node.rightParenthesis', config.space0);

        formatState.pushLevel('$methodName/node.thenStatement');
        final int? spacesForThenStatement = config.fixSpaces ? (node.thenStatement is EmptyStatement || node.thenStatement is Block? 0 : 1) : null;
        if (Constants.DEBUG_I_FORMATTER) logDebug('spacesForThenStatement: $spacesForThenStatement');
        formatState.copyEntity(node.thenStatement, astVisitor, '$methodName/node.thenStatement', spacesForThenStatement);
        formatState.popLevelAndIndent();

        if (node.elseKeyword == null)
            return;

        final bool indentElse = node.elseStatement is! IfStatement;

        formatState.copyEntity(node.elseKeyword, astVisitor, '$methodName/node.elseKeyword', config.space1);

        if (indentElse)
            formatState.pushLevel('$methodName/node.elseKeyword');

        final int? spacesForElseStatement = config.fixSpaces ? (node.elseStatement is EmptyStatement || node.elseStatement is Block? 0 : 1) : null;
        if (Constants.DEBUG_I_FORMATTER) logDebug('spacesForElseStatement: $spacesForElseStatement');
        formatState.copyEntity(node.elseStatement, astVisitor, '$methodName/node.elseStatement', spacesForElseStatement);

        if (indentElse)
            formatState.popLevelAndIndent();

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
