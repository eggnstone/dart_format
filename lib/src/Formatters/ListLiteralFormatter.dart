import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class ListLiteralFormatter extends TypedFormatter<ListLiteral>
{
    ListLiteralFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(ListLiteral node)
    {
        final int? spacesForLeftBracket = config.fixSpaces ? (node.offset == node.leftBracket.offset ? null : 0) : null;

        formatState.copyEntity(node.constKeyword, astVisitor, '$methodName/node.constKeyword');
        formatState.copyEntity(node.typeArguments, astVisitor, '$methodName/node.typeArguments');
        formatState.copyEntity(node.leftBracket, astVisitor, '$methodName/node.leftBracket', spacesForLeftBracket);
        formatState.pushLevel('$methodName/node.leftBracket');
        formatState.acceptListWithComma(node.elements, node.rightBracket, astVisitor, '$methodName/node.elements', leadingSpaces: config.space0, trimCommaText: config.fixSpaces);
        formatState.popLevelAndIndent();
        formatState.copyEntity(node.rightBracket, astVisitor, '$methodName/node.rightBracket', config.space0);
    }
}
