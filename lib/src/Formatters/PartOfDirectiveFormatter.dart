import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class PartOfDirectiveFormatter extends TypedFormatter<PartOfDirective>
{
    PartOfDirectiveFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(PartOfDirective node)
    {
        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        formatState.copyEntity(node.partKeyword, astVisitor, '$methodName/node.partKeyword');
        formatState.copyEntity(node.ofKeyword, astVisitor, '$methodName/node.ofKeyword');
        formatState.copyEntity(node.uri, astVisitor, '$methodName/node.uri');
        formatState.copyEntity(node.libraryName, astVisitor, '$methodName/node.libraryName');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon', config.space0);
    }
}
