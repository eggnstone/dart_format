import 'package:analyzer/dart/ast/ast.dart';

import '../../Config.dart';
import '../../Constants/Constants.dart';
import '../../FormatState.dart';
import '../../Tools/StringTools.dart';
import '../IFormatter.dart';

class ExpressionStatementFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ExpressionStatementFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ExpressionStatementFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! ExpressionStatement)
            throw FormatException('Not an ExpressionStatement: ${node.runtimeType}');

        formatState.copyEntity(node.expression, astVisitor, '$methodName/node.expression');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon');
    }
}