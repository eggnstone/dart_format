// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../Data/ConfigExtension.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class ExpressionFunctionBodyFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ExpressionFunctionBodyFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ExpressionFunctionBodyFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! ExpressionFunctionBody)
            throw FormatException('Not an ExpressionFunctionBody: ${node.runtimeType}');

        /*
        formatState.dump(node, 'node');
        //formatState.dumpList(node.sortedCommentAndAnnotations, 'sortedCommentAndAnnotations');
        formatState.dump2(node.keyword, node, 'keyword');
        formatState.dump2(node.functionDefinition, node.keyword, 'functionDefinition');
        formatState.dump2(node.expression, node.functionDefinition, 'expression');
        formatState.dump2(node.semicolon, node.expression, 'semicolon');
        */

        formatState.copyEntity(node.keyword, astVisitor, '$methodName/node.keyword');

        formatState.copyEntity(node.functionDefinition, astVisitor, '$methodName/node.functionDefinition');
        //final int? spacesForFunctionDefinition = config.fixSpaces ? (node.offset == node.functionDefinition.offset ? 0 : 1) : null;
        //formatState.copyEntity(node.functionDefinition, astVisitor, '$methodName/node.functionDefinition', spacesForFunctionDefinition);

        formatState.copyEntity(node.expression, astVisitor, '$methodName/node.expression', config.space1);
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon', config.space0);

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
