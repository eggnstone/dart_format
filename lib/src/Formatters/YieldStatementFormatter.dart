import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class YieldStatementFormatter extends TypedFormatter<YieldStatement>
{
    YieldStatementFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(YieldStatement node)
    {
        formatState.copyEntity(node.yieldKeyword, astVisitor, '$methodName/node.yieldKeyword');
        formatState.copyEntity(node.star, astVisitor, '$methodName/node.star');
        formatState.copyEntity(node.expression, astVisitor, '$methodName/node.expression');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon', config.space0);
    }
}
