import 'package:analyzer/dart/ast/ast.dart';

import 'TypedFormatter.dart';

class ImplementsClauseFormatter extends TypedFormatter<ImplementsClause>
{
    ImplementsClauseFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(ImplementsClause node)
    {
        formatState.copyEntity(node.implementsKeyword, astVisitor, '$methodName/node.implementsKeyword');
        formatState.acceptListWithComma(node.interfaces, null, astVisitor, '$methodName/node.interfaces', trimCommaText: config.fixSpaces);
    }
}
