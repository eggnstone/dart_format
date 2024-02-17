import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class YieldStatementFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    YieldStatementFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'YieldStatementFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! YieldStatement)
            throw FormatException('Not a YieldStatement: ${node.runtimeType}');

        formatState.copyEntity(node.yieldKeyword, astVisitor, '$methodName/node.yieldKeyword');
        formatState.copyEntity(node.star, astVisitor, '$methodName/node.star');
        formatState.copyEntity(node.expression, astVisitor, '$methodName/node.expression');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon');
    }
}
