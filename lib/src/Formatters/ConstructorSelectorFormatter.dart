import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class ConstructorSelectorFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ConstructorSelectorFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ConstructorSelectorFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! ConstructorSelector)
            throw FormatException('Not a ConstructorSelector: ${node.runtimeType}');

        formatState.copyEntity(node.period, astVisitor, '$methodName/node.period');
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name');
    }
}
