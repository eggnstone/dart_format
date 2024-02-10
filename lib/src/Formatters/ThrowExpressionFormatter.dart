import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class ThrowExpressionFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ThrowExpressionFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ThrowExpressionFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! ThrowExpression)
            throw FormatException('Not a ThrowExpression: ${node.runtimeType}');

        formatState.copyEntity(node.throwKeyword, astVisitor, '$methodName/node.throwKeyword');
        formatState.copyEntity(node.expression, astVisitor, '$methodName/node.expression');
    }
}
