import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class ConstructorFieldInitializerFormatter extends TypedFormatter<ConstructorFieldInitializer>
{
    ConstructorFieldInitializerFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(ConstructorFieldInitializer node)
    {
        formatState.copyEntity(node.thisKeyword, astVisitor, '$methodName/node.thisKeyword');
        formatState.copyEntity(node.period, astVisitor, '$methodName/node.period', config.space0);
        formatState.copyEntity(node.fieldName, astVisitor, '$methodName/node.fieldName', config.space0);
        formatState.copyEntity(node.equals, astVisitor, '$methodName/node.equals', config.space1);
        formatState.copyEntity(node.expression, astVisitor, '$methodName/node.expression', config.space1);
    }
}
