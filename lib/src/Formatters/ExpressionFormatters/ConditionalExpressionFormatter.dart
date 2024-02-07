import 'package:analyzer/dart/ast/ast.dart';

import '../../Config.dart';
import '../../Constants/Constants.dart';
import '../../FormatState.dart';
import '../../Tools/StringTools.dart';
import '../IFormatter.dart';

class ConditionalExpressionFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ConditionalExpressionFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ConditionalExpressionFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! ConditionalExpression)
            throw FormatException('Not a ConditionalExpression: ${node.runtimeType}');

        formatState.copyEntity(node.condition, astVisitor, '$methodName/node.condition');
        formatState.copyEntity(node.question, astVisitor, '$methodName/node.question');
        formatState.copyEntity(node.thenExpression, astVisitor, '$methodName/node.thenExpression');
        formatState.copyEntity(node.colon, astVisitor, '$methodName/node.colon');
        formatState.copyEntity(node.elseExpression, astVisitor, '$methodName/node.elseExpression');
    }
}
