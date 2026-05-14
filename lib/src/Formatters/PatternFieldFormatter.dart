import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class PatternFieldFormatter extends TypedFormatter<PatternField>
{
    PatternFieldFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(PatternField node)
    {
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name');
        formatState.copyEntity(node.pattern, astVisitor, '$methodName/node.pattern', node.name == null ? null : config.space1);
    }
}
