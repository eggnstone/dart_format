// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../Data/ConfigExtension.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class AssignmentExpressionFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    AssignmentExpressionFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'AssignmentExpressionFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! AssignmentExpression)
            throw FormatException('Not an AssignmentExpression: ${node.runtimeType}');

        /*formatState.dump(node, 'node');
        formatState.dump(node.leftHandSide, 'leftHandSide');
        formatState.dump(node.operator, 'operator');
        formatState.dump(node.rightHandSide, 'rightHandSide');*/

        formatState.copyEntity(node.leftHandSide, astVisitor, '$methodName/node.leftHandSide');
        formatState.copyEntity(node.operator, astVisitor, '$methodName/node.operator', config.space1);
        formatState.copyEntity(node.rightHandSide, astVisitor, '$methodName/node.rightHandSide', config.space1);

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
