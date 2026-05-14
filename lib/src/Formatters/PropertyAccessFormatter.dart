import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class PropertyAccessFormatter extends TypedFormatter<PropertyAccess>
{
    PropertyAccessFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(PropertyAccess node)
    {
        formatState.copyEntity(node.target, astVisitor, '$methodName/node.target');
        formatState.pushLevel('$methodName/node.target/after');
        formatState.copyEntity(node.operator, astVisitor, '$methodName/node.operator', config.space0);
        formatState.copyEntity(node.propertyName, astVisitor, '$methodName/node.propertyName', config.space0);
        formatState.popLevelAndIndent();
    }
}
