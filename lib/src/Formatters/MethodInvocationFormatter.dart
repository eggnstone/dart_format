// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../Data/ConfigExtension.dart';
import '../FormatState.dart';
import '../Tools/LogTools.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class MethodInvocationFormatter extends IFormatter
{
    static const String CLASS_NAME = 'MethodInvocationFormatter';

    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    MethodInvocationFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = '$CLASS_NAME.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! MethodInvocation)
            throw FormatException('Not a MethodInvocation: ${node.runtimeType}');

        /*formatState.dump(node, 'node');
        formatState.dump(node.target, 'target');
        formatState.dump(node.operator, 'operator');
        formatState.dump(node.methodName, 'methodName');
        formatState.dump(node.typeArguments, 'typeArguments');
        formatState.dump(node.argumentList, 'argumentList');*/

        final String textWithPossibleLineBreak = formatState.getText(node.offset, node.argumentList.offset);
        final bool pushLevel = textWithPossibleLineBreak.contains('\n');

        formatState.copyEntity(node.target, astVisitor, '$methodName/node.target');

        if (pushLevel)
            formatState.pushLevel('$methodName/node.target/after');

        // TODO: test and adjust
        final int? spacesForOperator = config.space0;//config.fixSpaces ? (node.offset == node.operator!.offset ? null : 1) : null;
        if (Constants.DEBUG_I_FORMATTER) logDebug('spacesForOperator: $spacesForOperator');
        formatState.copyEntity(node.operator, astVisitor, '$methodName/node.operator', spacesForOperator);
        /*if (node.operator != null)
        {
            final int? spacesForOperator = config.fixSpaces ? (node.offset == node.operator!.offset ? null : 1) : null;
            logDebug('spacesForOperator: $spacesForOperator');
            formatState.copyEntity(node.operator, astVisitor, '$methodName/node.operator', spacesForOperator);
        }*/
        //formatState.copyEntity(node.operator, astVisitor, '$methodName/node.operator');

        int? spacesForMethodName;
        if (config.fixSpaces && node.offset != node.methodName.offset)
            spacesForMethodName = node.operator == null ? 1 : 0;

        if (spacesForMethodName == 1)
            logWarning('Needs a test');

        if (Constants.DEBUG_I_FORMATTER) logDebug('spacesForMethodName: $spacesForMethodName');
        formatState.copyEntity(node.methodName, astVisitor, '$methodName/node.methodName', spacesForMethodName);

        formatState.copyEntity(node.typeArguments, astVisitor, '$methodName/node.typeArguments');
        formatState.copyEntity(node.argumentList, astVisitor, '$methodName/node.argumentList');

        if (pushLevel)
            formatState.popLevelAndIndent();

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
