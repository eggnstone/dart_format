import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
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
        log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! ForPartsWithExpression)
            throw FormatException('Not a ForPartsWithExpression: ${node.runtimeType}');

        formatState.copyEntity(node.initialization, astVisitor, '$methodName/node.initialization');
        formatState.copyEntity(node.leftSeparator, astVisitor, '$methodName/node.leftSeparator');
        formatState.copyEntity(node.condition, astVisitor, '$methodName/node.condition');
        formatState.copyEntity(node.rightSeparator, astVisitor, '$methodName/node.rightSeparator');
        formatState.acceptListWithComma(node.updaters, null, astVisitor, '$methodName/node.updaters');

        log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
