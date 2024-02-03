import 'package:analyzer/dart/ast/ast.dart';

import '../../Config.dart';
import '../../Constants.dart';
import '../../FormatState.dart';
import '../../Tools/StringTools.dart';
import '../IFormatter.dart';

class AwaitExpressionFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    AwaitExpressionFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'AwaitExpressionFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! AwaitExpression)
            throw FormatException('Not an AwaitExpression: ${node.runtimeType}');

        formatState.copyEntity(node.awaitKeyword, astVisitor, '$methodName/node.awaitKeyword'); // covered by tests
        formatState.copyEntity(node.expression, astVisitor, '$methodName/node.expression'); // covered by tests
    }
}
