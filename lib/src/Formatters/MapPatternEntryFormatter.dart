import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class MapPatternEntryFormatter extends TypedFormatter<MapPatternEntry>
{
    MapPatternEntryFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(MapPatternEntry node)
    {
        formatState.copyEntity(node.key, astVisitor, '$methodName/node.key');
        formatState.copyEntity(node.separator, astVisitor, '$methodName/node.separator', config.space0);
        formatState.copyEntity(node.value, astVisitor, '$methodName/node.value', config.space1);
    }
}
