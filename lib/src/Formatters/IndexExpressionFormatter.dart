// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../SimpleStack.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class IndexExpressionFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    IndexExpressionFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'IndexExpressionFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node)})', formatState.logIndent++);

        if (node is! IndexExpression)
            throw FormatException('Not an IndexExpression: ${node.runtimeType}');

        formatState.copyEntity(node.period, astVisitor, onGetStack: () => SimpleStack('$methodName/node.period'));
        formatState.copyEntity(node.target, astVisitor, onGetStack: () => SimpleStack('$methodName/node.target'));
        formatState.copyEntity(node.question, astVisitor, onGetStack: () => SimpleStack('$methodName/node.question'));
        formatState.copyEntity(node.leftBracket, astVisitor, onGetStack: () => SimpleStack('$methodName/node.leftBracket'));
        formatState.copyEntity(node.index, astVisitor, onGetStack: () => SimpleStack('$methodName/node.index'));
        formatState.copyEntity(node.rightBracket, astVisitor, onGetStack: () => SimpleStack('$methodName/node.rightBracket'));

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node)})', --formatState.logIndent);
    }
}
