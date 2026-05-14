import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class ExtendsClauseFormatter extends TypedFormatter<ExtendsClause>
{
    ExtendsClauseFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(ExtendsClause node)
    {
        formatState.copyEntity(node.extendsKeyword, astVisitor, '$methodName/node.extendsKeyword');
        formatState.copyEntity(node.superclass, astVisitor, '$methodName/node.superclass', config.space1);
    }
}
