/*
import 'package:analyzer/dart/ast/ast.dart';

import '../Data/Config.dart';
import '../FormatState.dart';
import 'TypedFormatter.dart';

class CascadeExpressionFormatter extends TypedFormatter<CascadeExpression>
{
    CascadeExpressionFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(CascadeExpression node)
    {
        formatState.copyEntity(node.target, astVisitor, '$methodName/node.target');
        //formatState.pushLevel('$methodName/node.cascadeSections');
        formatState.acceptList(node.cascadeSections, astVisitor, '$methodName/node.cascadeSections');
        //formatState.popLevelAndIndent();
    }
}
*/
