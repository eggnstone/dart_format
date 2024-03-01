// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../SimpleStack.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class CascadeExpressionFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    CascadeExpressionFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'CascadeExpressionFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node)})', formatState.logIndent++);

        if (node is! CascadeExpression)
            throw FormatException('Not a CascadeExpression: ${node.runtimeType}');

        formatState.copyEntity(node.target, astVisitor, onGetStack: () => SimpleStack('$methodName/node.target'));

        formatState.pushLevel('$methodName/node.cascadeSections');
        formatState.acceptList(node.cascadeSections, astVisitor, '$methodName/node.cascadeSections');
        formatState.popLevelAndIndent();

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node)})', --formatState.logIndent);
    }
}
