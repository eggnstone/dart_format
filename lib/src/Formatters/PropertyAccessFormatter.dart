// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../Data/ConfigExtension.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class PropertyAccessFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    PropertyAccessFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'PropertyAccessFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! PropertyAccess)
            throw FormatException('Not a PropertyAccess: ${node.runtimeType}');

        formatState.copyEntity(node.target, astVisitor, '$methodName/node.target');
        formatState.pushLevel('$methodName/node.target/after');
        formatState.copyEntity(node.operator, astVisitor, '$methodName/node.operator', config.space0);
        formatState.copyEntity(node.propertyName, astVisitor, '$methodName/node.propertyName', config.space0);
        formatState.popLevelAndIndent();

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
