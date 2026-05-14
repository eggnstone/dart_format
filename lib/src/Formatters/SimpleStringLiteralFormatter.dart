import 'package:analyzer/dart/ast/ast.dart';

import 'TypedFormatter.dart';

class SimpleStringLiteralFormatter extends TypedFormatter<SimpleStringLiteral>
{
    SimpleStringLiteralFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(SimpleStringLiteral node)
    {
        formatState.copyString(node.literal.offset, node.literal.end, '$methodName/node.literal');
    }
}
