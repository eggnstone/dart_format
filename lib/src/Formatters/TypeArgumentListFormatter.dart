import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class TypeArgumentListFormatter extends TypedFormatter<TypeArgumentList>
{
    TypeArgumentListFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(TypeArgumentList node)
    {
        formatState.copyEntity(node.leftBracket, astVisitor, '$methodName/node.leftBracket');
        formatState.pushLevel('$methodName/node.leftBracket');
        formatState.acceptListWithComma(node.arguments, node.rightBracket, astVisitor, '$methodName/node.arguments', leadingSpaces: config.space0, trimCommaText: config.fixSpaces);
        formatState.popLevelAndIndent();
        formatState.copyEntity(node.rightBracket, astVisitor, '$methodName/node.rightBracket', config.space0);
    }
}
