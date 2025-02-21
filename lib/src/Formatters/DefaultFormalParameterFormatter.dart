// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../Data/ConfigExtension.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class DefaultFormalParameterFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    DefaultFormalParameterFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'DefaultFormalParameterFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! DefaultFormalParameter)
            throw FormatException('Not a DefaultFormalParameter: ${node.runtimeType}');

        /*
        formatState.dump(node, 'node');
        formatState.dump(node.parameter, 'parameter');
        formatState.dump(node.separator, 'separator');
        formatState.dump(node.defaultValue, 'defaultValue');
        */

        formatState.copyEntity(node.parameter, astVisitor, '$methodName/node.parameter');

        int? spacesForSeparator;
        if (config.fixSpaces)
            spacesForSeparator = node.separator?.lexeme == '=' ? 1 : node.separator?.lexeme == ':' ? 0 : null;

        formatState.copyEntity(node.separator, astVisitor, '$methodName/node.separator', spacesForSeparator);
        formatState.copyEntity(node.defaultValue, astVisitor, '$methodName/node.defaultValue', config.space1);

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
