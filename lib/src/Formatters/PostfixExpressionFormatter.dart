import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class PostfixExpressionFormatter extends TypedFormatter<PostfixExpression>
{
    PostfixExpressionFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(PostfixExpression node)
    {
        formatState.copyEntity(node.operand, astVisitor, '$methodName/node.operand');
        formatState.copyEntity(node.operator, astVisitor, '$methodName/node.operator', config.space0);
    }
}
