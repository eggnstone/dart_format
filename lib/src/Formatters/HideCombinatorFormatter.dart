import 'package:analyzer/dart/ast/ast.dart';

import 'TypedFormatter.dart';

class HideCombinatorFormatter extends TypedFormatter<HideCombinator>
{
    HideCombinatorFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(HideCombinator node)
    {
        formatState.copyEntity(node.keyword, astVisitor, '$methodName/node.keyword');
        formatState.acceptListWithComma(node.hiddenNames, null, astVisitor, '$methodName/node.hiddenNames');
    }
}
