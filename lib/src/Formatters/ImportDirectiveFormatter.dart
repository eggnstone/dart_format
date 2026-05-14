import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class ImportDirectiveFormatter extends TypedFormatter<ImportDirective>
{
    ImportDirectiveFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(ImportDirective node)
    {
        //final String textWithPossibleLineBreak = formatState.getText(node.importKeyword.offset, node.semicolon.offset);
        //final bool pushLevel = true;//final bool pushLevel = textWithPossibleLineBreak.contains('\n');

        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        formatState.copyEntity(node.importKeyword, astVisitor, '$methodName/node.importKeyword');

        //if (pushLevel)
        formatState.pushLevel('$methodName/node.importKeyword/after');

        formatState.copyEntity(node.uri, astVisitor, '$methodName/node.uri', config.space1);
        formatState.acceptList(node.configurations, astVisitor, '$methodName/node.configurations');
        formatState.copyEntity(node.deferredKeyword, astVisitor, '$methodName/node.deferredKeyword');
        formatState.copyEntity(node.asKeyword, astVisitor, '$methodName/node.asKeyword', config.space1);
        formatState.copyEntity(node.prefix, astVisitor, '$methodName/node.prefix');
        formatState.acceptList(node.combinators, astVisitor, '$methodName/node.combinators');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon', config.space0);

        //if (pushLevel)
        formatState.popLevelAndIndent();
    }
}
