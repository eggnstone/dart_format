import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class MapLiteralEntryFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    MapLiteralEntryFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'MapLiteralEntryFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! MapLiteralEntry)
            throw FormatException('Not a MapLiteralEntry: ${node.runtimeType}');

        formatState.copyEntity(node.key, astVisitor, '$methodName/node.key');
        formatState.copyEntity(node.separator, astVisitor, '$methodName/node.separator');
        formatState.copyEntity(node.value, astVisitor, '$methodName/node.value');
    }
}
