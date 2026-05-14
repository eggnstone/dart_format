import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class PartDirectiveFormatter extends TypedFormatter<PartDirective>
{
    PartDirectiveFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(PartDirective node)
    {
        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        formatState.copyEntity(node.partKeyword, astVisitor, '$methodName/node.partKeyword');
        formatState.copyEntity(node.uri, astVisitor, '$methodName/node.uri');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon', config.space0);
    }
}
