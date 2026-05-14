import 'package:analyzer/dart/ast/ast.dart';

import 'TypedFormatter.dart';

class SymbolLiteralFormatter extends TypedFormatter<SymbolLiteral>
{
    SymbolLiteralFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(SymbolLiteral node)
    {
        formatState.copyEntity(node.poundSign, astVisitor, '$methodName/node.poundSign');
        formatState.acceptTokenListWithPeriod(node.components, astVisitor, '$methodName/node.components');
    }
}
