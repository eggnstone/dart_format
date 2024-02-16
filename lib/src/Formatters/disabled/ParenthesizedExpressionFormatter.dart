/*
import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class ParenthesizedExpressionFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ParenthesizedExpressionFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ParenthesizedExpressionFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! ParenthesizedExpression)
            throw FormatException('Not a ParenthesizedExpression: ${node.runtimeType}');

        formatState.copyEntity(node.leftParenthesis, astVisitor, '$methodName/node.leftParenthesis');
        formatState.copyEntity(node.expression, astVisitor, '$methodName/node.expression');
        formatState.copyEntity(node.rightParenthesis, astVisitor, '$methodName/node.rightParenthesis');
    }
}
*/
