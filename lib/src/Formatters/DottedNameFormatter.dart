import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';

import 'TypedFormatter.dart';

class DottedNameFormatter extends TypedFormatter<DottedName>
{
    DottedNameFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(DottedName node)
    {
        // node.tokens already contains the period tokens interleaved with the identifier tokens.
        for (final Token token in node.tokens)
            formatState.copyEntity(token, astVisitor, '$methodName/node.tokens');
    }
}
