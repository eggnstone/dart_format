// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class FunctionTypedFormalParameterFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    FunctionTypedFormalParameterFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'FunctionTypedFormalParameterFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! FunctionTypedFormalParameter)
            throw FormatException('Not a FunctionTypedFormalParameter: ${node.runtimeType}');

        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        formatState.copyEntity(node.returnType, astVisitor, '$methodName/node.returnType');
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name');
        formatState.copyEntity(node.parameters, astVisitor, '$methodName/node.parameters');
        // This whole formatter should not be necessary, because it doesn't do anything special.
        // But when FormalParameterListFormatter calls parameter.accept(astVisitor); the question is omitted.
        formatState.copyEntity(node.question, astVisitor, '$methodName/node.question');

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
