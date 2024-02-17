import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class PartOfDirectiveFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    PartOfDirectiveFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'PartOfDirectiveFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! PartOfDirective)
            throw FormatException('Not a PartOfDirective: ${node.runtimeType}');

        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        formatState.copyEntity(node.partKeyword, astVisitor, '$methodName/node.partKeyword');
        formatState.copyEntity(node.ofKeyword, astVisitor, '$methodName/node.ofKeyword');
        formatState.copyEntity(node.uri, astVisitor, '$methodName/node.uri');
        formatState.copyEntity(node.libraryName, astVisitor, '$methodName/node.libraryName');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon');
    }
}
