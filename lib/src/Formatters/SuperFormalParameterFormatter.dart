// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../Data/ConfigExtension.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class SuperFormalParameterFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    SuperFormalParameterFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'SuperFormalParameterFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! SuperFormalParameter)
            throw FormatException('Not a SuperFormalParameter: ${node.runtimeType}');

        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        formatState.copyEntity(node.requiredKeyword, astVisitor, '$methodName/node.requiredKeyword');

        if (node.type != null)
        {
            final int? spacesForType = config.fixSpaces ? (node.offset == node.type!.offset ? null : 1) : null;
            formatState.copyEntity(node.type, astVisitor, '$methodName/node.type', spacesForType);
        }

        final int? spacesForSuperKeyword = config.fixSpaces ? (node.offset == node.superKeyword.offset ? null : 1) : null;
        formatState.copyEntity(node.superKeyword, astVisitor, '$methodName/node.superKeyword', spacesForSuperKeyword);

        formatState.copyEntity(node.period, astVisitor, '$methodName/node.period', config.space0);
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name', config.space0);

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
