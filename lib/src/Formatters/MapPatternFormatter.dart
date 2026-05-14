import 'package:analyzer/dart/ast/ast.dart';

import 'TypedFormatter.dart';

class MapPatternFormatter extends TypedFormatter<MapPattern>
{
    MapPatternFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(MapPattern node)
    {
        formatState.copyEntity(node.typeArguments, astVisitor, '$methodName/node.typeArguments');
        formatState.copyEntity(node.leftBracket, astVisitor, '$methodName/node.leftBracket');
        formatState.acceptListWithComma(node.elements, node.rightBracket, astVisitor, '$methodName/node.elements');
        formatState.copyEntity(node.rightBracket, astVisitor, '$methodName/node.rightBracket');
    }
}
