// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../Data/ConfigExtension.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class BinaryExpressionFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    BinaryExpressionFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'BinaryExpressionFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! BinaryExpression)
            throw FormatException('Not a BinaryExpression: ${node.runtimeType}');

        formatState.copyEntity(node.leftOperand, astVisitor, '$methodName/node.leftOperand');
        formatState.pushLevel('$methodName/node.leftOperand/after');
        formatState.copyEntity(node.operator, astVisitor, '$methodName/node.operator', config.space1);
        formatState.copyEntity(node.rightOperand, astVisitor, '$methodName/node.rightOperand', config.space1);
        formatState.popLevelAndIndent();

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
