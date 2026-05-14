import 'package:analyzer/dart/ast/ast.dart';

import 'TypedFormatter.dart';

class ObjectPatternFormatter extends TypedFormatter<ObjectPattern>
{
    ObjectPatternFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(ObjectPattern node)
    {
        formatState.copyEntity(node.type, astVisitor, '$methodName/node.type');
        formatState.copyEntity(node.leftParenthesis, astVisitor, '$methodName/node.leftParenthesis');
        formatState.acceptListWithComma(node.fields, node.rightParenthesis, astVisitor, '$methodName/node.fields');
        formatState.copyEntity(node.rightParenthesis, astVisitor, '$methodName/node.rightParenthesis');
    }
}
