import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class WhileStatementFormatter extends TypedFormatter<WhileStatement>
{
    WhileStatementFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(WhileStatement node)
    {
        formatState.copyEntity(node.whileKeyword, astVisitor, '$methodName/node.whileKeyword');
        formatState.copyEntity(node.leftParenthesis, astVisitor, '$methodName/node.leftParenthesis', config.space1);
        formatState.copyEntity(node.condition, astVisitor, '$methodName/node.condition');
        formatState.copyEntity(node.rightParenthesis, astVisitor, '$methodName/node.rightParenthesis', config.space0);
        formatState.pushLevel('$methodName/node.body');
        formatState.copyEntity(node.body, astVisitor, '$methodName/node.body');
        formatState.popLevelAndIndent();
    }
}
