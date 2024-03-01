// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../SimpleStack.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class WhileStatementFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    WhileStatementFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'WhileStatementFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node)})', formatState.logIndent++);

        if (node is! WhileStatement)
            throw FormatException('Not a WhileStatement: ${node.runtimeType}');

        formatState.copyEntity(node.whileKeyword, astVisitor, onGetStack: () => SimpleStack('$methodName/node.whileKeyword'));
        formatState.copyEntity(node.leftParenthesis, astVisitor, onGetStack: () => SimpleStack('$methodName/node.leftParenthesis'));
        formatState.copyEntity(node.condition, astVisitor, onGetStack: () => SimpleStack('$methodName/node.condition'));
        formatState.copyEntity(node.rightParenthesis, astVisitor, onGetStack: () => SimpleStack('$methodName/node.rightParenthesis'));
        formatState.pushLevel('$methodName/node.body');
        formatState.copyEntity(node.body, astVisitor, onGetStack: () => SimpleStack('$methodName/node.body'));
        formatState.popLevelAndIndent();

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node)})', --formatState.logIndent);
    }
}
