// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class SimpleStringLiteralFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    SimpleStringLiteralFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'SimpleStringLiteralFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! SimpleStringLiteral)
            throw FormatException('Not a SimpleStringLiteral: ${node.runtimeType}');

        //logError('Before node.literal: ${node.literal.runtimeType} ${StringTools.toDisplayString(node.literal, Constants.MAX_DEBUG_LENGTH)}');
        formatState.copyString(node.literal.offset, node.literal.end, '$methodName/node.literal');
        //logError('After  node.literal: ${node.literal.runtimeType} ${StringTools.toDisplayString(node.literal, Constants.MAX_DEBUG_LENGTH)}');

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
