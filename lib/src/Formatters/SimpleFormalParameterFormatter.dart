// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../Data/ConfigExtension.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class SimpleFormalParameterFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    SimpleFormalParameterFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'SimpleFormalParameterFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! SimpleFormalParameter)
            throw FormatException('Not a SimpleFormalParameter: ${node.runtimeType}');

        /*
        logDebug('### SimpleFormalParameterFormatter: ${StringTools.toDisplayString(node)} = ${StringTools.toDisplayString(formatState.getText(node.offset, node.end))}');
        formatState.dump(node.parent, 'parent');
        formatState.dump(node, 'node');
        formatState.dump(node.type, 'type');
        formatState.dump(node.name, 'name');
        formatState.dump(node.keyword, 'keyword');
        */

        if (node.type != null)
        {
            //final int? spacesForType = config.fixSpaces ? (node.offset == node.type!.offset ? null : 1) : null;
            //logDebug('###   spacesForType: ${StringTools.toDisplayString(spacesForType)}');
            formatState.copyEntity(node.type, astVisitor, '$methodName/node.type');//, spacesForType);
        }

        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name', config.space1);

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
