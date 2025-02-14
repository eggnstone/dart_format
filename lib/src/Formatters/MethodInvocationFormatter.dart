// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../Data/ConfigExtension.dart';
import '../FormatState.dart';
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

        final String textWithPossibleLineBreak = formatState.getText(node.offset, node.argumentList.offset);
        final bool pushLevel = textWithPossibleLineBreak.contains('\n');

        formatState.copyEntity(node.target, astVisitor, '$methodName/node.target');

        if (pushLevel)
            formatState.pushLevel('$methodName/node.target/after');

        // TODO: test if operator is null?
        formatState.copyEntity(node.operator, astVisitor, '$methodName/node.operator', config.space0);
        formatState.copyEntity(node.methodName, astVisitor, '$methodName/node.methodName', config.space0);
        formatState.copyEntity(node.typeArguments, astVisitor, '$methodName/node.typeArguments');
        formatState.copyEntity(node.argumentList, astVisitor, '$methodName/node.argumentList');

        if (pushLevel)
            formatState.popLevelAndIndent();

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
