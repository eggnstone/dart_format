import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class ForPartsWithDeclarationsFormatter extends TypedFormatter<ForPartsWithDeclarations>
{
    ForPartsWithDeclarationsFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(ForPartsWithDeclarations node)
    {
        formatState.copyEntity(node.variables, astVisitor, '$methodName/node.variables');
        formatState.copyEntity(node.leftSeparator, astVisitor, '$methodName/node.leftSeparator', config.space0);
        formatState.copyEntity(node.condition, astVisitor, '$methodName/node.condition', config.space1);
        formatState.copyEntity(node.rightSeparator, astVisitor, '$methodName/node.rightSeparator', config.space0);
        formatState.acceptListWithComma(node.updaters, null, astVisitor, '$methodName/node.updaters', leadingSpaces: config.space1);
    }
}
