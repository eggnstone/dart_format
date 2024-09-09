// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../Data/ConfigExtension.dart';
import '../FormatState.dart';
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
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! ImportDirective)
            throw FormatException('Not an ImportDirective: ${node.runtimeType}');

        //final String textWithPossibleLineBreak = formatState.getText(node.importKeyword.offset, node.semicolon.offset);
        //final bool pushLevel = true;//final bool pushLevel = textWithPossibleLineBreak.contains('\n');

        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        formatState.copyEntity(node.importKeyword, astVisitor, '$methodName/node.importKeyword');

        //if (pushLevel)
        formatState.pushLevel('$methodName/node.importKeyword/after');

        formatState.copyEntity(node.uri, astVisitor, '$methodName/node.uri');//, config.space1);
        formatState.acceptList(node.configurations, astVisitor, '$methodName/node.configurations');
        formatState.copyEntity(node.deferredKeyword, astVisitor, '$methodName/node.deferredKeyword');
        formatState.copyEntity(node.asKeyword, astVisitor, '$methodName/node.asKeyword', config.space1);
        formatState.copyEntity(node.prefix, astVisitor, '$methodName/node.prefix');
        formatState.acceptList(node.combinators, astVisitor, '$methodName/node.combinators');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon', config.space0);

        //if (pushLevel)
        formatState.popLevelAndIndent();

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
