// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
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
        formatState.dump(node, 'node');
        formatState.dump(node.keyword, 'keyword');
        formatState.dump(node.requiredKeyword, 'requiredKeyword');
        formatState.dump(node.covariantKeyword, 'covariantKeyword');
        formatState.dump(node.type, 'type');
        formatState.dump(node.name, 'name');
        */

        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');

        if (node.keyword != null)
        {
            final int? spacesForKeyword = config.fixSpaces ? (node.offset == node.keyword!.offset ? null : 1) : null;
            formatState.copyEntity(node.keyword, astVisitor, '$methodName/node.keyword', spacesForKeyword);
        }

        if (node.requiredKeyword != null)
        {
            final int? spacesForRequiredKeyword = config.fixSpaces ? (node.offset == node.requiredKeyword!.offset ? null : 1) : null;
            formatState.copyEntity(node.requiredKeyword, astVisitor, '$methodName/node.requiredKeyword', spacesForRequiredKeyword);
        }

        if (node.covariantKeyword != null)
        {
            final int? spacesForCovariantKeyword = config.fixSpaces ? (node.offset == node.covariantKeyword!.offset ? null : 1) : null;
            formatState.copyEntity(node.covariantKeyword, astVisitor, '$methodName/node.covariantKeyword', spacesForCovariantKeyword);
        }

        if (node.type != null)
        {
            final int? spacesForType = config.fixSpaces ? (node.offset == node.type!.offset ? null : 1) : null;
            formatState.copyEntity(node.type, astVisitor, '$methodName/node.type', spacesForType);
        }

        if (node.name != null)
        {
            final int? spacesForName = config.fixSpaces ? (node.offset == node.name!.offset ? null : 1) : null;
            formatState.copyEntity(node.name, astVisitor, '$methodName/node.name', spacesForName);
        }

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
