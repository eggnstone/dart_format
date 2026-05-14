import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/line_info.dart';

import '../Copier.dart';
import '../Data/ConfigExtension.dart';
import '../Types/Spacing.dart';
import 'TypedFormatter.dart';

class ArgumentListFormatter extends TypedFormatter<ArgumentList>
{
    ArgumentListFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(ArgumentList node)
    {
        final Copier copier = Copier(astVisitor, config, formatState, node);
        final bool isBlockPattern = _isBlockPattern(node);

        copier.copyEntity(node.leftParenthesis, '$methodName/node.leftParenthesis', Spacing.zero);
        if (!isBlockPattern)
            formatState.pushLevel('$methodName/node.leftParenthesis');

        copier.acceptListWithComma(node.arguments, node.rightParenthesis, '$methodName/node.arguments', leadingSpaces: config.space0, trimCommaText: config.fixSpaces);
        if (!isBlockPattern)
            formatState.popLevelAndIndent();

        copier.copyEntity(node.rightParenthesis, '$methodName/node.rightParenthesis', Spacing.zero);
    }

    ArgumentList? _getCalleeArgumentList(Expression arg)
    {
        Expression target = arg;
        if (target is NamedExpression)
            target = target.expression;

        if (target is MethodInvocation)
            return target.argumentList;
        if (target is InstanceCreationExpression)
            return target.argumentList;
        if (target is FunctionExpressionInvocation)
            return target.argumentList;

        return null;
    }

    bool _isBlockPattern(ArgumentList node)
    {
        if (node.arguments.isEmpty)
            return false;

        final ArgumentList? inner = _getCalleeArgumentList(node.arguments.last);
        if (inner == null)
            return false;

        final CharacterLocation? outerLeft = formatState.getLocation(node.leftParenthesis.offset);
        final CharacterLocation? innerLeft = formatState.getLocation(inner.leftParenthesis.offset);
        final CharacterLocation? outerRight = formatState.getLocation(node.rightParenthesis.offset);
        final CharacterLocation? innerRight = formatState.getLocation(inner.rightParenthesis.offset);
        if (outerLeft == null || innerLeft == null || outerRight == null || innerRight == null)
            return false;

        return outerLeft.lineNumber == innerLeft.lineNumber && outerRight.lineNumber == innerRight.lineNumber;
    }
}
