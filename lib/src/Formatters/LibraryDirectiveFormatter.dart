import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class LibraryDirectiveFormatter extends TypedFormatter<LibraryDirective>
{
    LibraryDirectiveFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(LibraryDirective node)
    {
        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        formatState.copyEntity(node.libraryKeyword, astVisitor, '$methodName/node.libraryKeyword');
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon', config.space0);
    }
}
