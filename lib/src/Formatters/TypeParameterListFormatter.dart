import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class TypeParameterListFormatter extends TypedFormatter<TypeParameterList>
{
    TypeParameterListFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(TypeParameterList node)
    {
        formatState.copyEntity(node.leftBracket, astVisitor, '$methodName/node.leftBracket');
        formatState.pushLevel('$methodName/node.leftBracket');
        formatState.acceptListWithComma(node.typeParameters, node.rightBracket, astVisitor, '$methodName/node.typeParameters', leadingSpaces: config.space0, trimCommaText: config.fixSpaces);
        formatState.popLevelAndIndent();
        formatState.copyEntity(node.rightBracket, astVisitor, '$methodName/node.rightBracket', config.space0);
    }
}
