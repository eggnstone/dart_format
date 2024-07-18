// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class ConditionalExpressionFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ConditionalExpressionFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ConditionalExpressionFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! ConditionalExpression)
            throw FormatException('Not a ConditionalExpression: ${node.runtimeType}');

        formatState.copyEntity(node.condition, astVisitor, '$methodName/node.condition');

        formatState.pushLevel('$methodName/node.question+thenExpression');
        formatState.copyEntity(node.question, astVisitor, '$methodName/node.question');
        formatState.copyEntity(node.thenExpression, astVisitor, '$methodName/node.thenExpression');
        formatState.popLevelAndIndent();

        formatState.pushLevel('$methodName/node.colon+elseExpression');
        formatState.copyEntity(node.colon, astVisitor,  '$methodName/node.colon');
        formatState.copyEntity(node.elseExpression, astVisitor, '$methodName/node.elseExpression');
        formatState.popLevelAndIndent();

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
