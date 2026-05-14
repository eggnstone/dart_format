import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class VariableDeclarationListFormatter extends TypedFormatter<VariableDeclarationList>
{
    VariableDeclarationListFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(VariableDeclarationList node)
    {
        final String textWithPossibleLineBreak = formatState.getText(node.offset, node.variables.first.offset);
        //log('$methodName: textWithPossibleLineBreak: ${StringTools.toDisplayString(textWithPossibleLineBreak)}', 0);
        final bool pushLevel = textWithPossibleLineBreak.contains('\n');

        bool alreadyPushed = false;

        // TODO: use sortedCommentAndAnnotations or metadata?
        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        //formatState.acceptList(node.metadata, astVisitor, '$methodName/node.metadata');

        if (node.lateKeyword != null)
        {
            formatState.copyEntity(node.lateKeyword, astVisitor, '$methodName/node.lateKeyword');
            if (pushLevel && !alreadyPushed)
            {
                alreadyPushed = true;
                formatState.pushLevel('$methodName/node.lateKeyword/after');
            }
        }

        if (node.keyword != null)
        {
            formatState.copyEntity(node.keyword, astVisitor, '$methodName/node.keyword');
            if (pushLevel && !alreadyPushed)
            {
                alreadyPushed = true;
                formatState.pushLevel('$methodName/node.keyword/after');
            }
        }

        if (node.type != null)
        {
            final int? spacesForType = config.fixSpaces ? (node.offset == node.type!.offset ? null : 1) : null;
            formatState.copyEntity(node.type, astVisitor, '$methodName/node.type', spacesForType);
            if (pushLevel && !alreadyPushed)
            {
                alreadyPushed = true;
                formatState.pushLevel('$methodName/node.type/after');
            }
        }

        formatState.acceptListWithComma(node.variables, null, astVisitor, '$methodName/node.variables', leadingSpaces: config.space1);

        if (alreadyPushed)
            formatState.popLevelAndIndent();
    }
}
