import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class FormalParameterDefaultClauseFormatter extends TypedFormatter<FormalParameterDefaultClause>
{
    FormalParameterDefaultClauseFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(FormalParameterDefaultClause node)
    {
        int? spacesForSeparator;
        if (config.fixSpaces)
            spacesForSeparator = node.separator.lexeme == '=' ? 1 : node.separator.lexeme == ':' ? 0 : null;

        formatState.copyEntity(node.separator, astVisitor, '$methodName/node.separator', spacesForSeparator);
        formatState.copyEntity(node.value, astVisitor, '$methodName/node.value', config.space1);
    }
}
