import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class FieldFormalParameterFormatter extends TypedFormatter<FieldFormalParameter>
{
    FieldFormalParameterFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(FieldFormalParameter node)
    {
        final int? spacesForCovariantKeyword = node.covariantKeyword == null ? null : config.fixSpaces ? (node.offset == node.covariantKeyword!.offset ? null : 1) : null;
        final int? spacesForRequiredKeyword = node.requiredKeyword == null ? null : config.fixSpaces ? (node.offset == node.requiredKeyword!.offset ? null : 1) : null;
        final int? spacesForKeyword = node.keyword == null ? null : config.fixSpaces ? (node.offset == node.keyword!.offset ? null : 1) : null;
        final int? spacesForType = node.type == null ? null : config.fixSpaces ? (node.offset == node.type!.offset ? null : 1) : null;
        final int? spacesForThisKeyword = config.fixSpaces ? (node.offset == node.thisKeyword.offset ? null : 1) : null;

        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        formatState.copyEntity(node.covariantKeyword, astVisitor, '$methodName/node.covariantKeyword', spacesForCovariantKeyword);
        formatState.copyEntity(node.requiredKeyword, astVisitor, '$methodName/node.requiredKeyword', spacesForRequiredKeyword);
        formatState.copyEntity(node.keyword, astVisitor, '$methodName/node.keyword', spacesForKeyword);
        formatState.copyEntity(node.type, astVisitor, '$methodName/node.type', spacesForType);
        formatState.copyEntity(node.thisKeyword, astVisitor, '$methodName/node.thisKeyword', spacesForThisKeyword);
        formatState.copyEntity(node.period, astVisitor, '$methodName/node.period', config.space0);
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name', config.space0);
        formatState.copyEntity(node.typeParameters, astVisitor, '$methodName/node.typeParameters', config.space0);
        formatState.copyEntity(node.parameters, astVisitor, '$methodName/node.parameters', config.space0);
        formatState.copyEntity(node.question, astVisitor, '$methodName/node.question', config.space0);
    }
}
