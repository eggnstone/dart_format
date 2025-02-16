// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../Data/ConfigExtension.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class VariableDeclarationListFormatter extends IFormatter
{
    static const String CLASS_NAME = 'VariableDeclarationListFormatter';

    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    VariableDeclarationListFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = '$CLASS_NAME.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! VariableDeclarationList)
            throw FormatException('Not a VariableDeclarationList: ${node.runtimeType}');

        final String textWithPossibleLineBreak = formatState.getText(node.offset, node.variables.first.offset);
        //log('$CLASS_NAME: textWithPossibleLineBreak: ${StringTools.toDisplayString(textWithPossibleLineBreak)}', 0);
        final bool pushLevel = textWithPossibleLineBreak.contains('\n');

        bool alreadyPushed = false;

        // TODO: use sortedCommentAndAnnotations or metadata?
        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        //formatState.acceptList(node.metadata, astVisitor, '$methodName/node.metadata');

        if (node.lateKeyword != null)
        {
            formatState.copyEntity(node.lateKeyword, astVisitor, '$methodName/node.lateKeyword');
            if (pushLevel && !alreadyPushed)
            {
                alreadyPushed = true;
                formatState.pushLevel('$methodName/node.lateKeyword/after');
            }
        }

        if (node.keyword != null)
        {
            formatState.copyEntity(node.keyword, astVisitor, '$methodName/node.keyword');
            if (pushLevel && !alreadyPushed)
            {
                alreadyPushed = true;
                formatState.pushLevel('$methodName/node.keyword/after');
            }
        }

        if (node.type != null)
        {
            final int? spacesForType = config.fixSpaces ? (node.offset == node.type!.offset ? null : 1) : null;
            formatState.copyEntity(node.type, astVisitor, '$methodName/node.type', spacesForType);
            if (pushLevel && !alreadyPushed)
            {
                alreadyPushed = true;
                formatState.pushLevel('$methodName/node.type/after');
            }
        }

        formatState.acceptListWithComma(node.variables, null, astVisitor, '$methodName/node.variables', config.space1);

        if (alreadyPushed)
            formatState.popLevelAndIndent();

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
