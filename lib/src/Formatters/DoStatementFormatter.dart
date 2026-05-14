import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class DoStatementFormatter extends TypedFormatter<DoStatement>
{
    DoStatementFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(DoStatement node)
    {
        formatState.copyEntity(node.doKeyword, astVisitor, '$methodName/node.doKeyword');
        formatState.copyEntity(node.body, astVisitor, '$methodName/node.body', config.space1);
        formatState.copyEntity(node.whileKeyword, astVisitor, '$methodName/node.whileKeyword', config.space1);
        formatState.copyEntity(node.leftParenthesis, astVisitor, '$methodName/node.leftParenthesis', config.space1);
        formatState.copyEntity(node.condition, astVisitor, '$methodName/node.condition');
        formatState.copyEntity(node.rightParenthesis, astVisitor, '$methodName/node.rightParenthesis', config.space0);
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon', config.space0);
    }
}
