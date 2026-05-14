import 'package:analyzer/dart/ast/ast.dart';

import 'TypedFormatter.dart';

class InterpolationExpressionFormatter extends TypedFormatter<InterpolationExpression>
{
    InterpolationExpressionFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(InterpolationExpression node)
    {
        formatState.copyEntity(node.leftBracket, astVisitor, '$methodName/node.leftBracket');
        formatState.copyEntity(node.expression, astVisitor, '$methodName/node.expression');
        formatState.copyEntity(node.rightBracket, astVisitor, '$methodName/node.rightBracket');
    }
}
