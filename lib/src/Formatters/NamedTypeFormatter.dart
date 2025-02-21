// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../Data/ConfigExtension.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class NamedTypeFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    NamedTypeFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'NamedTypeFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! NamedType)
            throw FormatException('Not a NamedType: ${node.runtimeType}');

        /*formatState.dump(node, 'node');
        formatState.dump(node.name2, 'name');
        formatState.dump(node.typeArguments, 'typeArguments');*/

        formatState.copyEntity(node.name2, astVisitor, '$methodName/node.name2');
        formatState.copyEntity(node.typeArguments, astVisitor, '$methodName/node.typeArguments', config.space0);

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
