import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class ReturnStatementFormatter extends TypedFormatter<ReturnStatement>
{
    ReturnStatementFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(ReturnStatement node)
    {
        formatState.copyEntity(node.returnKeyword, astVisitor, '$methodName/node.returnKeyword');
        formatState.copyEntity(node.expression, astVisitor, '$methodName/node.expression', config.space1);
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon', config.space0);
    }
}
