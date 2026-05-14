import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class BinaryExpressionFormatter extends TypedFormatter<BinaryExpression>
{
    BinaryExpressionFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(BinaryExpression node)
    {
        formatState.copyEntity(node.leftOperand, astVisitor, '$methodName/node.leftOperand');
        formatState.pushLevel('$methodName/node.leftOperand/after');
        formatState.copyEntity(node.operator, astVisitor, '$methodName/node.operator', config.space1);
        formatState.copyEntity(node.rightOperand, astVisitor, '$methodName/node.rightOperand', config.space1);
        formatState.popLevelAndIndent();
    }
}
