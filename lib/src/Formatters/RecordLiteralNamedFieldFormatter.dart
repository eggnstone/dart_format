import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class RecordLiteralNamedFieldFormatter extends TypedFormatter<RecordLiteralNamedField>
{
    RecordLiteralNamedFieldFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(RecordLiteralNamedField node)
    {
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name');
        formatState.copyEntity(node.colon, astVisitor, '$methodName/node.colon', config.space0);
        formatState.copyEntity(node.fieldExpression, astVisitor, '$methodName/node.fieldExpression', config.space1);
    }
}
