/*
import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import '../Data/Config.dart';
import '../FormatState.dart';
import 'TypedFormatter.dart';

class LibraryAugmentationDirectiveFormatter extends TypedFormatter<LibraryAugmentationDirective>
{
    LibraryAugmentationDirectiveFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(LibraryAugmentationDirective node)
    {
        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        formatState.copyEntity(node.libraryKeyword, astVisitor, '$methodName/node.libraryKeyword');
        formatState.copyEntity(node.augmentKeyword, astVisitor, '$methodName/node.augmentKeyword');
        formatState.copyEntity(node.uri, astVisitor, '$methodName/node.uri');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon', config.space0);
    }
}
*/
