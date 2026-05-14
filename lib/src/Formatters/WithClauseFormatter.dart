import 'package:analyzer/dart/ast/ast.dart';

import 'TypedFormatter.dart';

class WithClauseFormatter extends TypedFormatter<WithClause>
{
    WithClauseFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(WithClause node)
    {
        formatState.copyEntity(node.withKeyword, astVisitor, '$methodName/node.withKeyword');
        formatState.acceptListWithComma(node.mixinTypes, null, astVisitor, '$methodName/node.mixinTypes', trimCommaText: config.fixSpaces);
    }
}
