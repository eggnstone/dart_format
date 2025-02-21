// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class FunctionExpressionFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    FunctionExpressionFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'FunctionExpressionFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! FunctionExpression)
            throw FormatException('Not a FunctionExpression: ${node.runtimeType}');

        /*
        formatState.dump(node, 'node');
        formatState.dump(node.typeParameters, 'typeParameters');
        formatState.dump(node.parameters, 'parameters');
        formatState.dump(node.body, 'body');
        */

        //formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');

        //formatState.copyEntity(node.typeParameters, astVisitor, '$methodName/node.typeParameters');

        /*if (node.parameters != null)
        {
            //final int? spacesForParameters = config.fixSpaces ? 0 : null;
            formatState.copyEntity(node.parameters, astVisitor, '$methodName/node.parameters', config.space0);
        }*/

        formatState.copyEntity(node.typeParameters, astVisitor, '$methodName/node.typeParameters');
        formatState.copyEntity(node.parameters, astVisitor, '$methodName/node.parameters');

        formatState.consumeSpacesBeforeFunctionBody(node.body, config);
        formatState.copyEntity(node.body, astVisitor, '$methodName/node.body');

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
