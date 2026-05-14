import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/line_info.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class ConditionalExpressionFormatter extends TypedFormatter<ConditionalExpression>
{
    ConditionalExpressionFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(ConditionalExpression node)
    {
        formatState.copyEntity(node.condition, astVisitor, '$methodName/node.condition');

        // Only push a level for the `?+then` group when `?` actually starts a new
        // source line. If it sits on the same line as the condition's last token
        // the branch shares that line's indent context, so an extra pushLevel would
        // over-indent any multi-line content inside the branch.
        final bool questionOnNewLine = _isOnDifferentLine(node.condition.end, node.question.offset);
        if (questionOnNewLine)
            formatState.pushLevel('$methodName/node.question+thenExpression');
        formatState.copyEntity(node.question, astVisitor, '$methodName/node.question', config.space1);
        formatState.copyEntity(node.thenExpression, astVisitor, '$methodName/node.thenExpression', config.space1);
        if (questionOnNewLine)
            formatState.popLevelAndIndent();

        // Same rule for `:+else`.
        final bool colonOnNewLine = _isOnDifferentLine(node.thenExpression.end, node.colon.offset);
        if (colonOnNewLine)
            formatState.pushLevel('$methodName/node.colon+elseExpression');
        formatState.copyEntity(node.colon, astVisitor, '$methodName/node.colon', config.space1);
        formatState.copyEntity(node.elseExpression, astVisitor, '$methodName/node.elseExpression', config.space1);
        if (colonOnNewLine)
            formatState.popLevelAndIndent();
    }

    /// Returns true when [offset1] and [offset2] resolve to different source lines.
    /// When line info isn't available (test harness with a fake ParseStringResult)
    /// falls back to scanning the source between the two offsets for a newline.
    bool _isOnDifferentLine(int offset1, int offset2)
    {
        final CharacterLocation? location1 = formatState.getLocation(offset1);
        final CharacterLocation? location2 = formatState.getLocation(offset2);
        if (location1 != null && location2 != null)
            return location1.lineNumber != location2.lineNumber;

        if (offset1 > offset2)
            return false;

        return formatState.getText(offset1, offset2).contains('\n');
    }
}
