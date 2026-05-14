import 'package:analyzer/dart/ast/ast.dart';

import 'TypedFormatter.dart';

class FunctionExpressionFormatter extends TypedFormatter<FunctionExpression>
{
    FunctionExpressionFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(FunctionExpression node)
    {
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
    }
}
