// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../Data/ConfigExtension.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class ForStatementFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ForStatementFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ForStatementFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! ForStatement)
            throw FormatException('Not a ForStatement: ${node.runtimeType}');

        formatState.copyEntity(node.awaitKeyword, astVisitor, '$methodName/node.awaitKeyword');
        formatState.copyEntity(node.forKeyword, astVisitor, '$methodName/node.forKeyword');
        formatState.copyEntity(node.leftParenthesis, astVisitor, '$methodName/node.leftParenthesis', config.space1);
        formatState.copyEntity(node.forLoopParts, astVisitor, '$methodName/node.forLoopParts');
        formatState.copyEntity(node.rightParenthesis, astVisitor, '$methodName/node.rightParenthesis', config.space0);
        formatState.pushLevel('$methodName/node.body');
        formatState.copyEntity(node.body, astVisitor, '$methodName/node.body');
        formatState.popLevelAndIndent();

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
