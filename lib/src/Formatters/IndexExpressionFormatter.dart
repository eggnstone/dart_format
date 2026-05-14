import 'package:analyzer/dart/ast/ast.dart';

import 'TypedFormatter.dart';

class IndexExpressionFormatter extends TypedFormatter<IndexExpression>
{
    IndexExpressionFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(IndexExpression node)
    {
        // TODO: test if period is null?
        formatState.copyEntity(node.period, astVisitor, '$methodName/node.period');//, config.space0);
        // TODO: test if target is null?
        formatState.copyEntity(node.target, astVisitor, '$methodName/node.target');//, config.space0);
        formatState.copyEntity(node.question, astVisitor, '$methodName/node.question');
        formatState.copyEntity(node.leftBracket, astVisitor, '$methodName/node.leftBracket');
        formatState.copyEntity(node.index, astVisitor, '$methodName/node.index');
        formatState.copyEntity(node.rightBracket, astVisitor, '$methodName/node.rightBracket');
    }
}
