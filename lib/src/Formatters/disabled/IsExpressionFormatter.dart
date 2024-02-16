/*
import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class IsExpressionFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    IsExpressionFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'IsExpressionFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! IsExpression)
            throw FormatException('Not an IsExpression: ${node.runtimeType}');

        formatState.copyEntity(node.expression, astVisitor, '$methodName/node.expression');
        formatState.copyEntity(node.isOperator, astVisitor, '$methodName/node.isOperator');
        formatState.copyEntity(node.notOperator, astVisitor, '$methodName/node.notOperator');
        formatState.copyEntity(node.type, astVisitor, '$methodName/node.type');
    }
}
*/
