/*
import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class PostfixExpressionFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    PostfixExpressionFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'PostfixExpressionFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! PostfixExpression)
            throw FormatException('Not a PostfixExpression: ${node.runtimeType}');

        formatState.copyEntity(node.operand, astVisitor, '$methodName/node.operand'); // covered by tests
        formatState.copyEntity(node.operator, astVisitor, '$methodName/node.operator'); // covered by tests
    }
}
*/
