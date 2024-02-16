/*
import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class PrefixExpressionFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    PrefixExpressionFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'PrefixExpressionFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! PrefixExpression)
            throw FormatException('Not a PrefixExpression: ${node.runtimeType}');

        formatState.copyEntity(node.operator, astVisitor, '$methodName/node.operator');
        formatState.copyEntity(node.operand, astVisitor, '$methodName/node.operand');
    }
}
*/
