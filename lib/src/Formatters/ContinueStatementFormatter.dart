import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class ContinueStatementFormatter extends TypedFormatter<ContinueStatement>
{
    ContinueStatementFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(ContinueStatement node)
    {
        formatState.copyEntity(node.continueKeyword, astVisitor, '$methodName/node.continueKeyword');
        formatState.copyEntity(node.label, astVisitor, '$methodName/node.label');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon', config.space0);
    }
}
