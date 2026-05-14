import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class AsExpressionFormatter extends TypedFormatter<AsExpression>
{
    AsExpressionFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(AsExpression node)
    {
        formatState.copyEntity(node.expression, astVisitor, '$methodName/node.expression');
        formatState.copyEntity(node.asOperator, astVisitor, '$methodName/node.asOperator', config.space1);
        formatState.copyEntity(node.type, astVisitor, '$methodName/node.type', config.space1);
    }
}
