import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class PatternVariableDeclarationStatementFormatter extends TypedFormatter<PatternVariableDeclarationStatement>
{
    PatternVariableDeclarationStatementFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(PatternVariableDeclarationStatement node)
    {
        formatState.copyEntity(node.declaration, astVisitor, '$methodName/node.declaration');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon', config.space0);
    }
}
