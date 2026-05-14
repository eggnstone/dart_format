import 'package:analyzer/dart/ast/ast.dart';

import 'TypedFormatter.dart';

class FunctionExpressionFormatter extends TypedFormatter<FunctionExpression>
{
    FunctionExpressionFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(FunctionExpression node)
    {
        formatState.copyEntity(node.typeParameters, astVisitor, '$methodName/node.typeParameters');
        formatState.copyEntity(node.parameters, astVisitor, '$methodName/node.parameters');

        formatState.consumeSpacesBeforeFunctionBody(node.body, config);
        formatState.copyEntity(node.body, astVisitor, '$methodName/node.body');
    }
}
