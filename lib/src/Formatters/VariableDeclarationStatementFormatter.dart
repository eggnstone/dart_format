import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class VariableDeclarationStatementFormatter extends TypedFormatter<VariableDeclarationStatement>
{
    VariableDeclarationStatementFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(VariableDeclarationStatement node)
    {
        formatState.copyEntity(node.variables, astVisitor, '$methodName/node.variables');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon', config.space0);
    }
}
