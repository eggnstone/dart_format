// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class VariableDeclarationFormatter extends IFormatter
{
    static const String CLASS_NAME = 'VariableDeclarationListFormatter';

    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    VariableDeclarationFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = '$CLASS_NAME.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! VariableDeclaration)
            throw FormatException('Not a VariableDeclaration: ${node.runtimeType}');

        bool pushLevel = false;
        if (node.initializer != null)
        {
            final String textWithPossibleLineBreak = formatState.getText(node.offset, node.initializer!.offset);
            pushLevel = textWithPossibleLineBreak.contains('\n');
            log('textWithPossibleLineBreak:            ${StringTools.toDisplayString(textWithPossibleLineBreak)}', 0);
            log('pushLevel:                            $pushLevel', 0);
        }

        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name');

        if (pushLevel)
            formatState.pushLevel('$methodName/node.name/after');

        formatState.copyEntity(node.equals, astVisitor, '$methodName/node.equals');

        if (node.initializer is AdjacentStrings)
        {
            final String textWithPossibleLineBreakEquals = formatState.getText(node.equals!.offset, node.initializer!.offset);
            final bool pushLevelEquals = textWithPossibleLineBreakEquals.contains('\n');
            log('textWithPossibleLineBreakEquals:      ${StringTools.toDisplayString(textWithPossibleLineBreakEquals)}', 0);
            log('pushLevelEquals:                      $pushLevelEquals', 0);
            final String textWithPossibleLineBreakInitializer = formatState.getText(node.initializer!.offset, node.initializer!.end);
            final bool pushLevelInitializer = textWithPossibleLineBreakInitializer.contains('\n');
            log('textWithPossibleLineBreakInitializer: ${StringTools.toDisplayString(textWithPossibleLineBreakInitializer)}', 0);
            log('pushLevelInitializer:                 $pushLevelInitializer', 0);

            final bool combinedPushLevel = !pushLevelEquals && pushLevelInitializer;
            log('combinedPushLevel:                    $combinedPushLevel', 0);

            if (combinedPushLevel)
                formatState.pushLevel('$methodName/node.initializer/before');

            formatState.copyEntity(node.initializer, astVisitor, '$methodName/node.initializer');

            if (combinedPushLevel)
                formatState.popLevelAndIndent();
        }
        else
            formatState.copyEntity(node.initializer, astVisitor, '$methodName/node.initializer');

        if (pushLevel)
            formatState.popLevelAndIndent();

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
