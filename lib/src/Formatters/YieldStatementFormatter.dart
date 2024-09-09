// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../Data/ConfigExtension.dart';
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
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! YieldStatement)
            throw FormatException('Not a YieldStatement: ${node.runtimeType}');

        formatState.copyEntity(node.yieldKeyword, astVisitor, '$methodName/node.yieldKeyword');
        formatState.copyEntity(node.star, astVisitor, '$methodName/node.star');
        formatState.copyEntity(node.expression, astVisitor, '$methodName/node.expression');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon', config.space0);

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
