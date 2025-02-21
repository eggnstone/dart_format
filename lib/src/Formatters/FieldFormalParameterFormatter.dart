// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../Data/ConfigExtension.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class FieldFormalParameterFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    FieldFormalParameterFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'FieldFormalParameterFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! FieldFormalParameter)
            throw FormatException('Not a FieldFormalParameter: ${node.runtimeType}');

        /*
        formatState.dump(node, 'node');
        formatState.dump(node.type, 'node.type');
        */

        final int? spacesForRequiredKeyword = node.requiredKeyword == null ? null : config.fixSpaces ? (node.offset == node.requiredKeyword!.offset ? null : 1) : null;
        final int? spacesForType = node.type == null ? null : config.fixSpaces ? (node.offset == node.type!.offset ? null : 1) : null;
        final int? spacesForThisKeyword = config.fixSpaces ? (node.offset == node.thisKeyword.offset ? null : 1) : null;

        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        formatState.copyEntity(node.requiredKeyword, astVisitor, '$methodName/node.requiredKeyword', spacesForRequiredKeyword);
        formatState.copyEntity(node.type, astVisitor, '$methodName/node.type', spacesForType);
        formatState.copyEntity(node.thisKeyword, astVisitor, '$methodName/node.thisKeyword', spacesForThisKeyword);
        formatState.copyEntity(node.period, astVisitor, '$methodName/node.period', config.space0);
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name', config.space0);

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
