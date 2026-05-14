import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class ConditionalExpressionFormatter extends TypedFormatter<ConditionalExpression>
{
    ConditionalExpressionFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(ConditionalExpression node)
    {
        formatState.copyEntity(node.condition, astVisitor, '$methodName/node.condition');

        formatState.pushLevel('$methodName/node.question+thenExpression');
        formatState.copyEntity(node.question, astVisitor, '$methodName/node.question', config.space1);
        formatState.copyEntity(node.thenExpression, astVisitor, '$methodName/node.thenExpression', config.space1);
        formatState.popLevelAndIndent();

        formatState.pushLevel('$methodName/node.colon+elseExpression');
        formatState.copyEntity(node.colon, astVisitor, '$methodName/node.colon', config.space1);
        formatState.copyEntity(node.elseExpression, astVisitor, '$methodName/node.elseExpression', config.space1);
        formatState.popLevelAndIndent();
    }
}
