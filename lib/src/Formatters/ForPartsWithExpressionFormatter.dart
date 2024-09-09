// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../Data/ConfigExtension.dart';
import '../FormatState.dart';
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
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! ForPartsWithExpression)
            throw FormatException('Not a ForPartsWithExpression: ${node.runtimeType}');

        formatState.copyEntity(node.initialization, astVisitor, '$methodName/node.initialization');
        formatState.copyEntity(node.leftSeparator, astVisitor, '$methodName/node.leftSeparator', config.space0);
        formatState.copyEntity(node.condition, astVisitor, '$methodName/node.condition');
        formatState.copyEntity(node.rightSeparator, astVisitor, '$methodName/node.rightSeparator', config.space0);
        formatState.acceptListWithComma(node.updaters, null, astVisitor, '$methodName/node.updaters');

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
