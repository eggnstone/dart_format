// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class PrefixedIdentifierFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    PrefixedIdentifierFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'PrefixedIdentifierFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! PrefixedIdentifier)
            throw FormatException('Not a PrefixedIdentifier: ${node.runtimeType}');

        formatState.copyEntity(node.prefix, astVisitor, '$methodName/node.prefix');
        formatState.pushLevel('$methodName/node.prefix/after');
        formatState.copyEntity(node.period, astVisitor, '$methodName/node.period');
        formatState.copyEntity(node.identifier, astVisitor, '$methodName/node.identifier');
        formatState.popLevelAndIndent();

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
