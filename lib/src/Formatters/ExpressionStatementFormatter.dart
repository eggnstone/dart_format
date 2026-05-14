import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class ExpressionStatementFormatter extends TypedFormatter<ExpressionStatement>
{
    ExpressionStatementFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(ExpressionStatement node)
    {
        /*
        formatState.dump(node, 'node');
        formatState.dump(node.expression, 'expression');
        formatState.dump(node.semicolon, 'semicolon');*/

        formatState.copyEntity(node.expression, astVisitor, '$methodName/node.expression');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon', config.space0);
    }
}
