import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class SuperFormalParameterFormatter extends TypedFormatter<SuperFormalParameter>
{
    SuperFormalParameterFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(SuperFormalParameter node)
    {
        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        formatState.copyEntity(node.covariantKeyword, astVisitor, '$methodName/node.covariantKeyword');
        formatState.copyEntity(node.requiredKeyword, astVisitor, '$methodName/node.requiredKeyword');

        if (node.keyword != null)
        {
            final int? spacesForKeyword = config.fixSpaces ? (node.offset == node.keyword!.offset ? null : 1) : null;
            formatState.copyEntity(node.keyword, astVisitor, '$methodName/node.keyword', spacesForKeyword);
        }

        if (node.type != null)
        {
            final int? spacesForType = config.fixSpaces ? (node.offset == node.type!.offset ? null : 1) : null;
            formatState.copyEntity(node.type, astVisitor, '$methodName/node.type', spacesForType);
        }

        final int? spacesForSuperKeyword = config.fixSpaces ? (node.offset == node.superKeyword.offset ? null : 1) : null;
        formatState.copyEntity(node.superKeyword, astVisitor, '$methodName/node.superKeyword', spacesForSuperKeyword);

        formatState.copyEntity(node.period, astVisitor, '$methodName/node.period', config.space0);
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name', config.space0);
        formatState.copyEntity(node.typeParameters, astVisitor, '$methodName/node.typeParameters', config.space0);
        formatState.copyEntity(node.parameters, astVisitor, '$methodName/node.parameters', config.space0);
        formatState.copyEntity(node.question, astVisitor, '$methodName/node.question', config.space0);
    }
}
