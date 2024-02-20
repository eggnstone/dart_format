import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
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
        log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! IfStatement)
            throw FormatException('Not an IfStatement: ${node.runtimeType}');

        formatState.copyEntity(node.ifKeyword, astVisitor, '$methodName/node.ifKeyword');
        formatState.copyEntity(node.leftParenthesis, astVisitor, '$methodName/node.leftParenthesis');
        formatState.copyEntity(node.expression, astVisitor, '$methodName/node.expression');
        formatState.copyEntity(node.rightParenthesis, astVisitor, '$methodName/node.rightParenthesis');

        formatState.pushLevel('$methodName/node.thenStatement');
        formatState.copyEntity(node.thenStatement, astVisitor, '$methodName/node.thenStatement');
        formatState.popLevelAndIndent();

        if (node.elseKeyword == null)
            return;

        final bool indentElse = node.elseStatement is! IfStatement;

        formatState.copyEntity(node.elseKeyword, astVisitor, '$methodName/node.elseKeyword');
        if (indentElse)
            formatState.pushLevel('$methodName/node.elseKeyword');

        formatState.copyEntity(node.elseStatement, astVisitor, '$methodName/node.elseStatement');

        if (indentElse)
            formatState.popLevelAndIndent();

        log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
