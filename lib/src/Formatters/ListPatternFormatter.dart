import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class ListPatternFormatter extends TypedFormatter<ListPattern>
{
    ListPatternFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(ListPattern node)
    {
        final int? spacesForLeftBracket = config.fixSpaces ? (node.leftBracket.offset == node.offset ? null : 0) : null;

        formatState.copyEntity(node.typeArguments, astVisitor, '$methodName/node.typeArguments');
        formatState.copyEntity(node.leftBracket, astVisitor, '$methodName/node.leftBracket', spacesForLeftBracket);
        formatState.acceptListWithComma(node.elements, node.rightBracket, astVisitor, '$methodName/node.elements', leadingSpaces: config.space0, trimCommaText: config.fixSpaces);
        formatState.copyEntity(node.rightBracket, astVisitor, '$methodName/node.rightBracket', config.space0);
    }
}
