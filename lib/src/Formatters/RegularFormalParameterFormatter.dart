import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class RegularFormalParameterFormatter extends TypedFormatter<RegularFormalParameter>
{
    RegularFormalParameterFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(RegularFormalParameter node)
    {
        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');

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

        if (node.constFinalOrVarKeyword != null)
        {
            final int? spacesForKeyword = config.fixSpaces ? (node.offset == node.constFinalOrVarKeyword!.offset ? null : 1) : null;
            formatState.copyEntity(node.constFinalOrVarKeyword, astVisitor, '$methodName/node.constFinalOrVarKeyword', spacesForKeyword);
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

        formatState.copyEntity(node.functionTypedSuffix, astVisitor, '$methodName/node.functionTypedSuffix', config.space0);
        formatState.copyEntity(node.defaultClause, astVisitor, '$methodName/node.defaultClause');
    }
}
