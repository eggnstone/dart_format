import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class LabelFormatter extends TypedFormatter<Label>
{
    LabelFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(Label node)
    {
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name');
        formatState.copyEntity(node.colon, astVisitor, '$methodName/node.colon', config.space0);
    }
}
