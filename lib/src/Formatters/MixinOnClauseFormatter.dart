import 'package:analyzer/dart/ast/ast.dart';

import 'TypedFormatter.dart';

class MixinOnClauseFormatter extends TypedFormatter<MixinOnClause>
{
    MixinOnClauseFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(MixinOnClause node)
    {
        formatState.copyEntity(node.onKeyword, astVisitor, '$methodName/node.onKeyword');
        formatState.acceptListWithComma(node.superclassConstraints, null, astVisitor, '$methodName/node.superclassConstraints', trimCommaText: config.fixSpaces);
    }
}
