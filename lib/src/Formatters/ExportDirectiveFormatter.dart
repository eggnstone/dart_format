import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class ExportDirectiveFormatter extends TypedFormatter<ExportDirective>
{
    ExportDirectiveFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(ExportDirective node)
    {
        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        formatState.copyEntity(node.exportKeyword, astVisitor, '$methodName/node.exportKeyword');
        formatState.copyEntity(node.uri, astVisitor, '$methodName/node.uri', config.space1);
        formatState.acceptList(node.combinators, astVisitor, '$methodName/node.combinators');
        formatState.acceptList(node.configurations, astVisitor, '$methodName/node.configurations');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon', config.space0);
    }
}
