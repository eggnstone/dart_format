// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../SimpleStack.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class SwitchExpressionFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    SwitchExpressionFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'SwitchExpressionFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node)})', formatState.logIndent++);

        if (node is! SwitchExpression)
            throw FormatException('Not a SwitchExpression: ${node.runtimeType}');

        // Why does this not work with the default formatter?
        // The commas were missing then!
        formatState.copyEntity(node.switchKeyword, astVisitor, onGetStack: () => SimpleStack('$methodName/node.switchKeyword'));
        formatState.copyEntity(node.leftParenthesis, astVisitor, onGetStack: () => SimpleStack('$methodName/node.leftParenthesis'));
        formatState.copyEntity(node.expression, astVisitor, onGetStack: () => SimpleStack('$methodName/node.expression'));
        formatState.copyEntity(node.rightParenthesis, astVisitor, onGetStack: () => SimpleStack('$methodName/node.rightParenthesis'));
        formatState.copyEntity(node.leftBracket, astVisitor, onGetStack: () => SimpleStack('$methodName/node.leftBracket'));
        //formatState.pushLevel('$methodName/node.members');
        formatState.acceptListWithComma(node.cases, node.rightBracket, astVisitor, '$methodName/node.cases');
        //formatState.popLevelAndIndent();
        formatState.copyEntity(node.rightBracket, astVisitor, onGetStack: () => SimpleStack('$methodName/node.rightBracket'));

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node)})', --formatState.logIndent);
    }
}
