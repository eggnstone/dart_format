// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../SimpleStack.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class ImportDirectiveFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ImportDirectiveFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ImportDirectiveFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node)})', formatState.logIndent++);

        if (node is! ImportDirective)
            throw FormatException('Not an ImportDirective: ${node.runtimeType}');

        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        formatState.copyEntity(node.importKeyword, astVisitor, onGetStack: () => SimpleStack('$methodName/node.importKeyword'));
        formatState.copyEntity(node.uri, astVisitor, onGetStack: () => SimpleStack('$methodName/node.uri'));
        formatState.acceptList(node.configurations, astVisitor, '$methodName/node.configurations');
        formatState.copyEntity(node.deferredKeyword, astVisitor, onGetStack: () => SimpleStack('$methodName/node.deferredKeyword'));
        formatState.copyEntity(node.asKeyword, astVisitor, onGetStack: () => SimpleStack('$methodName/node.asKeyword'));
        formatState.copyEntity(node.prefix, astVisitor, onGetStack: () => SimpleStack('$methodName/node.prefix'));
        formatState.acceptList(node.combinators, astVisitor, '$methodName/node.combinators');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon');

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node)})', --formatState.logIndent);
    }
}
