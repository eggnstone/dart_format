// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class MethodInvocationFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    MethodInvocationFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'MethodInvocationFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! MethodInvocation)
            throw FormatException('Not a MethodInvocation: ${node.runtimeType}');

        final bool pushLevel = node.target != null && node.operator != null && node.operator!.type == TokenType.PERIOD;

        formatState.copyEntity(node.target, astVisitor, '$methodName/node.target');

        if (pushLevel)
            formatState.pushLevel('$methodName/node.target/after');

        formatState.copyEntity(node.operator, astVisitor, '$methodName/node.operator');
        formatState.copyEntity(node.methodName, astVisitor, '$methodName/node.methodName');
        formatState.copyEntity(node.typeArguments, astVisitor, '$methodName/node.typeArguments');

        if (pushLevel)
            formatState.popLevelAndIndent();

        formatState.copyEntity(node.argumentList, astVisitor, '$methodName/node.argumentList');

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
