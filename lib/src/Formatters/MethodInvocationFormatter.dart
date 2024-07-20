// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:eggnstone_dart/eggnstone_dart.dart';

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

        /*logDebug('node.operator:                ${node.operator}');
        logDebug('node.operator:                ${node.operator?.type}');
        logDebug('node.operator:                ${node.operator?.keyword}');*/

        final bool pushLevel = node.operator?.type == TokenType.PERIOD && formatState.getText(node.offset, node.end).contains('\n');

        /*logDebug('all:                          ${StringTools.toDisplayString(formatState.getText(node.offset, node.end))}');

        if (node.operator != null)
            logDebug('operator - end:               ${StringTools.toDisplayString(formatState.getText(node.operator!.offset, node.end))}');

        logDebug('node.target:                  ${node.target}');
        if (node.target != null)
            logDebug('target - end:                 ${StringTools.toDisplayString(formatState.getText(node.target!.offset, node.target!.end))}');

        //logDebug('node.target.beginToken:       ${node.target?.beginToken}');
        //logDebug('node.target.beginToken.next:  ${node.target?.beginToken.next}');

        if (node.operator != null)
            logDebug('operator:                     ${StringTools.toDisplayString(formatState.getText(node.operator!.offset, node.operator!.end))}');

        logDebug('node.methodName:              ${node.methodName}');
        logDebug('methodName:                   ${StringTools.toDisplayString(formatState.getText(node.methodName.offset, node.methodName.end))}');

        logDebug('node.methodName.beginToken:   ${node.methodName.beginToken}');*/

        formatState.copyEntity(node.target, astVisitor, '$methodName/node.target');

        if (pushLevel)
            formatState.pushLevel('$methodName/node.target/after');

        formatState.copyEntity(node.operator, astVisitor, '$methodName/node.operator');
        formatState.copyEntity(node.methodName, astVisitor, '$methodName/node.methodName');
        formatState.copyEntity(node.typeArguments, astVisitor, '$methodName/node.typeArguments');
        formatState.copyEntity(node.argumentList, astVisitor, '$methodName/node.argumentList');

        if (pushLevel)
            formatState.popLevelAndIndent();

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
