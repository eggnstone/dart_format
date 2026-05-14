import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class AssignmentExpressionFormatter extends TypedFormatter<AssignmentExpression>
{
    AssignmentExpressionFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(AssignmentExpression node)
    {
        formatState.copyEntity(node.leftHandSide, astVisitor, '$methodName/node.leftHandSide');
        formatState.copyEntity(node.operator, astVisitor, '$methodName/node.operator', config.space1);
        formatState.copyEntity(node.rightHandSide, astVisitor, '$methodName/node.rightHandSide', config.space1);
    }
}
