import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class NamedArgumentFormatter extends TypedFormatter<NamedArgument>
{
    NamedArgumentFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(NamedArgument node)
    {
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name');
        formatState.copyEntity(node.colon, astVisitor, '$methodName/node.colon', config.space0);
        formatState.copyEntity(node.argumentExpression, astVisitor, '$methodName/node.argumentExpression', config.space1);
    }
}
