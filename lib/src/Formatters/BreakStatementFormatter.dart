import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class BreakStatementFormatter extends TypedFormatter<BreakStatement>
{
    BreakStatementFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(BreakStatement node)
    {
        formatState.copyEntity(node.breakKeyword, astVisitor, '$methodName/node.breakKeyword');
        formatState.copyEntity(node.label, astVisitor, '$methodName/node.label');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon', config.space0);
    }
}
