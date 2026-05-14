import 'package:analyzer/dart/ast/ast.dart';

import 'TypedFormatter.dart';

class InstanceCreationExpressionFormatter extends TypedFormatter<InstanceCreationExpression>
{
    InstanceCreationExpressionFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(InstanceCreationExpression node)
    {
        formatState.copyEntity(node.keyword, astVisitor, '$methodName/node.keyword');

        final int? spacesForConstructorName = config.fixSpaces ? (node.offset == node.constructorName.offset ? null : 1) : null;
        formatState.copyEntity(node.constructorName, astVisitor, '$methodName/node.constructorName', spacesForConstructorName);

        formatState.copyEntity(node.argumentList, astVisitor, '$methodName/node.argumentList');
    }
}
