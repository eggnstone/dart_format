import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class IsExpressionFormatter extends TypedFormatter<IsExpression>
{
    IsExpressionFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(IsExpression node)
    {
        formatState.copyEntity(node.expression, astVisitor, '$methodName/node.expression');
        formatState.copyEntity(node.isOperator, astVisitor, '$methodName/node.isOperator', config.space1);
        formatState.copyEntity(node.notOperator, astVisitor, '$methodName/node.notOperator', config.space0);
        formatState.copyEntity(node.type, astVisitor, '$methodName/node.type', config.space1);
    }
}
