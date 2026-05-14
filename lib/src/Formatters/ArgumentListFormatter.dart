import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/source/line_info.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class ArgumentListFormatter extends TypedFormatter<ArgumentList>
{
    ArgumentListFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(ArgumentList node)
    {
        final bool shouldIndentBody = _shouldIndentBody(node);

        formatState.copyEntity(node.leftParenthesis, astVisitor, '$methodName/node.leftParenthesis', config.space0);
        if (shouldIndentBody)
            formatState.pushLevel('$methodName/node.leftParenthesis');

        formatState.acceptListWithComma(node.arguments, node.rightParenthesis, astVisitor, '$methodName/node.arguments', leadingSpaces: config.space0, trimCommaText: config.fixSpaces);
        if (shouldIndentBody)
            formatState.popLevelAndIndent();

        formatState.copyEntity(node.rightParenthesis, astVisitor, '$methodName/node.rightParenthesis', config.space0);
    }

    /// Returns the inner opening/closing brackets of [arg] when [arg] is something
    /// whose own brackets could collapse with the surrounding ArgumentList's parens:
    /// another call's `(`/`)`, a closure body's `{`/`}`, or a collection literal's
    /// `(`/`)` / `[`/`]` / `{`/`}`. Returns null otherwise.
    ({SyntacticEntity left, SyntacticEntity right})? _getInnerBrackets(Expression arg)
    {
        Expression target = arg;
        if (target is NamedExpression)
            target = target.expression;

        if (target is MethodInvocation)
            return (left: target.argumentList.leftParenthesis, right: target.argumentList.rightParenthesis);

        if (target is InstanceCreationExpression)
            return (left: target.argumentList.leftParenthesis, right: target.argumentList.rightParenthesis);

        if (target is FunctionExpressionInvocation)
            return (left: target.argumentList.leftParenthesis, right: target.argumentList.rightParenthesis);

        if (target is FunctionExpression && target.body is BlockFunctionBody)
        {
            final Block block = (target.body as BlockFunctionBody).block;
            return (left: block.leftBracket, right: block.rightBracket);
        }

        if (target is RecordLiteral)
            return (left: target.leftParenthesis, right: target.rightParenthesis);

        if (target is ListLiteral)
            return (left: target.leftBracket, right: target.rightBracket);

        if (target is SetOrMapLiteral)
            return (left: target.leftBracket, right: target.rightBracket);

        return null;
    }

    /// Returns true when this ArgumentList's body should be indented one level (the
    /// normal case). Returns false only when the last argument's own brackets share
    /// source lines with the outer parens — either another call's `(`/`)` or a
    /// closure body's `{`/`}` — so the outer indent would be redundant.
    bool _shouldIndentBody(ArgumentList node)
    {
        if (node.arguments.isEmpty)
            return true;

        final ({SyntacticEntity left, SyntacticEntity right})? innerBrackets = _getInnerBrackets(node.arguments.last);
        if (innerBrackets == null)
            return true;

        final CharacterLocation? outerLeft = formatState.getLocation(node.leftParenthesis.offset);
        final CharacterLocation? innerLeft = formatState.getLocation(innerBrackets.left.offset);
        final CharacterLocation? outerRight = formatState.getLocation(node.rightParenthesis.offset);
        final CharacterLocation? innerRight = formatState.getLocation(innerBrackets.right.offset);
        if (outerLeft == null || innerLeft == null || outerRight == null || innerRight == null)
            return true;

        final bool openingsOnDifferentLines = outerLeft.lineNumber != innerLeft.lineNumber;
        final bool closingsOnDifferentLines = outerRight.lineNumber != innerRight.lineNumber;
        return openingsOnDifferentLines || closingsOnDifferentLines;
    }
}
