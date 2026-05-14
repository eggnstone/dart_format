import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Data/ConfigExtension.dart';
import '../Tools/StringTools.dart';
import 'TypedFormatter.dart';

class VariableDeclarationFormatter extends TypedFormatter<VariableDeclaration>
{
    VariableDeclarationFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(VariableDeclaration node)
    {
        bool pushLevel = false;
        if (node.initializer != null)
        {
            final String textWithPossibleLineBreak = formatState.getText(node.offset, node.initializer!.offset);
            pushLevel = textWithPossibleLineBreak.contains('\n');
            if (Constants.DEBUG_I_FORMATTER)
            {
                log('textWithPossibleLineBreak:            ${StringTools.toDisplayString(textWithPossibleLineBreak)}', 0);
                log('pushLevel:                            $pushLevel', 0);
            }
        }

        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name');

        if (pushLevel)
            formatState.pushLevel('$methodName/node.name/after');

        formatState.copyEntity(node.equals, astVisitor, '$methodName/node.equals', config.space1);

        if (node.initializer is AdjacentStrings)
        {
            final String textWithPossibleLineBreakEquals = formatState.getText(node.equals!.offset, node.initializer!.offset);
            final bool pushLevelEquals = textWithPossibleLineBreakEquals.contains('\n');
            final String textWithPossibleLineBreakInitializer = formatState.getText(node.initializer!.offset, node.initializer!.end);
            final bool pushLevelInitializer = textWithPossibleLineBreakInitializer.contains('\n');
            final bool combinedPushLevel = !pushLevelEquals && pushLevelInitializer;

            if (Constants.DEBUG_I_FORMATTER)
            {
                log('textWithPossibleLineBreakEquals:      ${StringTools.toDisplayString(textWithPossibleLineBreakEquals)}', 0);
                log('pushLevelEquals:                      $pushLevelEquals', 0);
                log('textWithPossibleLineBreakInitializer: ${StringTools.toDisplayString(textWithPossibleLineBreakInitializer)}', 0);
                log('pushLevelInitializer:                 $pushLevelInitializer', 0);
                log('combinedPushLevel:                    $combinedPushLevel', 0);
            }

            if (combinedPushLevel)
                formatState.pushLevel('$methodName/node.initializer/before');

            formatState.copyEntity(node.initializer, astVisitor, '$methodName/node.initializer');

            if (combinedPushLevel)
                formatState.popLevelAndIndent();
        }
        else
            formatState.copyEntity(node.initializer, astVisitor, '$methodName/node.initializer', config.space1);

        if (pushLevel)
            formatState.popLevelAndIndent();
    }
}
