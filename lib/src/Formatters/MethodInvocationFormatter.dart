import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import '../Tools/LogTools.dart';
import 'TypedFormatter.dart';

class MethodInvocationFormatter extends TypedFormatter<MethodInvocation>
{
    MethodInvocationFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(MethodInvocation node)
    {
        final String textWithPossibleLineBreak = formatState.getText(node.offset, node.argumentList.offset);
        final bool pushLevel = textWithPossibleLineBreak.contains('\n');

        formatState.copyEntity(node.target, astVisitor, '$methodName/node.target');

        if (pushLevel)
            formatState.pushLevel('$methodName/node.target/after');

        // TODO: test and adjust
        final int? spacesForOperator = config.space0;//config.fixSpaces ? (node.offset == node.operator!.offset ? null : 1) : null;
        //if (Constants.DEBUG_I_FORMATTER) logDebug('spacesForOperator: $spacesForOperator');
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
            logWarning('MethodInvocationFormatter: Needs a test');

        //if (Constants.DEBUG_I_FORMATTER) logDebug('spacesForMethodName: $spacesForMethodName');
        formatState.copyEntity(node.methodName, astVisitor, '$methodName/node.methodName', spacesForMethodName);

        formatState.copyEntity(node.typeArguments, astVisitor, '$methodName/node.typeArguments');
        formatState.copyEntity(node.argumentList, astVisitor, '$methodName/node.argumentList');

        if (pushLevel)
            formatState.popLevelAndIndent();
    }
}
