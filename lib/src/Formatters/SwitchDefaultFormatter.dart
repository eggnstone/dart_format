import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class SwitchDefaultFormatter extends TypedFormatter<SwitchDefault>
{
    SwitchDefaultFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(SwitchDefault node)
    {
        formatState.acceptList(node.labels, astVisitor, '$methodName/node.labels');
        formatState.copyEntity(node.keyword, astVisitor, '$methodName/node.keyword');
        formatState.copyEntity(node.colon, astVisitor, '$methodName/node.colon', config.space0);
        formatState.pushLevel('$methodName/node.statements');
        formatState.acceptList(node.statements, astVisitor, '$methodName/node.statements');
        formatState.popLevelAndIndent();
    }
}
