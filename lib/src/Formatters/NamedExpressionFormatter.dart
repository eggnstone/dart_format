import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class NamedExpressionFormatter extends TypedFormatter<NamedExpression>
{
    NamedExpressionFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(NamedExpression node)
    {
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name');
        formatState.copyEntity(node.expression, astVisitor, '$methodName/node.expression', config.space1);
    }
}
