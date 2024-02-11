import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class ExportDirectiveFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ExportDirectiveFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ExportDirectiveFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! ExportDirective)
            throw FormatException('Not an ExportDirective: ${node.runtimeType}');

        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        formatState.copyEntity(node.exportKeyword, astVisitor, '$methodName/node.exportKeyword'); // covered by tests
        formatState.copyEntity(node.uri, astVisitor, '$methodName/node.uri'); // covered by tests
        formatState.acceptList(node.combinators, astVisitor, '$methodName/node.combinators');
        formatState.acceptList(node.configurations, astVisitor, '$methodName/node.configurations');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon');
    }
}
