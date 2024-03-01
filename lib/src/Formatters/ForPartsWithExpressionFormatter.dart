// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../SimpleStack.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class ForPartsWithExpressionFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ForPartsWithExpressionFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ForPartsWithExpressionFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node)})', formatState.logIndent++);

        if (node is! ForPartsWithExpression)
            throw FormatException('Not a ForPartsWithExpression: ${node.runtimeType}');

        formatState.copyEntity(node.initialization, astVisitor, onGetStack: () => SimpleStack('$methodName/node.initialization'));
        formatState.copyEntity(node.leftSeparator, astVisitor, onGetStack: () => SimpleStack('$methodName/node.leftSeparator'));
        formatState.copyEntity(node.condition, astVisitor, onGetStack: () => SimpleStack('$methodName/node.condition'));
        formatState.copyEntity(node.rightSeparator, astVisitor, onGetStack: () => SimpleStack('$methodName/node.rightSeparator'));
        formatState.acceptListWithComma(node.updaters, null, astVisitor, '$methodName/node.updaters');

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node)})', --formatState.logIndent);
    }
}
