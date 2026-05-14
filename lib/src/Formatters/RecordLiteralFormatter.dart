import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class RecordLiteralFormatter extends TypedFormatter<RecordLiteral>
{
    RecordLiteralFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(RecordLiteral node)
    {
        formatState.copyEntity(node.constKeyword, astVisitor, '$methodName/node.constKeyword', config.space0);

        final int? spacesForLeftParenthesis = config.fixSpaces ? (node.offset == node.leftParenthesis.offset ? null : 1) : null;
        formatState.copyEntity(node.leftParenthesis, astVisitor, '$methodName/node.leftParenthesis', spacesForLeftParenthesis);
        formatState.pushLevel('$methodName/node.leftParenthesis');
        formatState.acceptListWithComma(node.fields, node.rightParenthesis, astVisitor, '$methodName/node.fields');
        formatState.popLevelAndIndent();
        formatState.copyEntity(node.rightParenthesis, astVisitor, '$methodName/node.rightParenthesis', config.space0);
    }
}
