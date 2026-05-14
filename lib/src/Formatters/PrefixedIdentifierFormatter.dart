import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class PrefixedIdentifierFormatter extends TypedFormatter<PrefixedIdentifier>
{
    PrefixedIdentifierFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(PrefixedIdentifier node)
    {
        formatState.copyEntity(node.prefix, astVisitor, '$methodName/node.prefix');

        formatState.pushLevel('$methodName/node.prefix/after');
        formatState.copyEntity(node.period, astVisitor, '$methodName/node.period', config.space0);
        formatState.copyEntity(node.identifier, astVisitor, '$methodName/node.identifier', config.space0);
        formatState.popLevelAndIndent();
    }
}
