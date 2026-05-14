import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class ForPartsWithExpressionFormatter extends TypedFormatter<ForPartsWithExpression>
{
    ForPartsWithExpressionFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(ForPartsWithExpression node)
    {
        formatState.copyEntity(node.initialization, astVisitor, '$methodName/node.initialization');
        formatState.copyEntity(node.leftSeparator, astVisitor, '$methodName/node.leftSeparator', config.space0);
        formatState.copyEntity(node.condition, astVisitor, '$methodName/node.condition');
        formatState.copyEntity(node.rightSeparator, astVisitor, '$methodName/node.rightSeparator', config.space0);
        formatState.acceptListWithComma(node.updaters, null, astVisitor, '$methodName/node.updaters');
    }
}
