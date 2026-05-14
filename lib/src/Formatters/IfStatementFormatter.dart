import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/line_info.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class IfStatementFormatter extends TypedFormatter<IfStatement>
{
    IfStatementFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(IfStatement node)
    {
        formatState.copyEntity(node.ifKeyword, astVisitor, '$methodName/node.ifKeyword', config.getSpacesZeroOne(node, node.ifKeyword));
        formatState.copyEntity(node.leftParenthesis, astVisitor, '$methodName/node.leftParenthesis', config.space1);
        formatState.copyEntity(node.expression, astVisitor, '$methodName/node.expression', config.space0);
        formatState.copyEntity(node.caseClause, astVisitor, '$methodName/node.caseClause', config.space1);
        formatState.copyEntity(node.rightParenthesis, astVisitor, '$methodName/node.rightParenthesis', config.space0);

        formatState.pushLevel('$methodName/node.thenStatement');
        formatState.copyEntity(node.thenStatement, astVisitor, '$methodName/node.thenStatement', config.getSpacesEmptyStatementZeroOne(node.thenStatement));
        formatState.popLevelAndIndent();

        if (node.elseKeyword == null)
            return;

        // Normally the `else` body gets its own indent level. Skip that push only
        // for the canonical `else if (...)` chain — i.e. when the elseStatement is
        // another IfStatement that sits on the SAME source line as `else`. When
        // `else` and `if` are on different lines, the inner `if` is the else's
        // body and should be indented one level past `else` like any other body.
        final bool elseIfOnSameLine =
            node.elseStatement is IfStatement &&
                !_isOnDifferentLine(node.elseKeyword!.end, node.elseStatement!.offset);
        final bool indentElse = !elseIfOnSameLine;

        formatState.copyEntity(node.elseKeyword, astVisitor, '$methodName/node.elseKeyword', config.space1);

        if (indentElse)
            formatState.pushLevel('$methodName/node.elseKeyword');

        formatState.copyEntity(node.elseStatement, astVisitor, '$methodName/node.elseStatement', node.elseStatement == null ? null : config.getSpacesEmptyStatementZeroOne(node.elseStatement!));

        if (indentElse)
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
