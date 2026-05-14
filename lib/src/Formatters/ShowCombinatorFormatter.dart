import 'package:analyzer/dart/ast/ast.dart';

import 'TypedFormatter.dart';

class ShowCombinatorFormatter extends TypedFormatter<ShowCombinator>
{
    ShowCombinatorFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(ShowCombinator node)
    {
        formatState.copyEntity(node.keyword, astVisitor, '$methodName/node.keyword');
        formatState.acceptListWithComma(node.shownNames, null, astVisitor, '$methodName/node.shownNames');
    }
}
