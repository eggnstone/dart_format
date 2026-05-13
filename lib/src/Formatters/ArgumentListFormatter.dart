// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/line_info.dart';

import '../Constants/Constants.dart';
import '../Copier.dart';
import '../Data/Config.dart';
import '../Data/ConfigExtension.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import '../Types/Spacing.dart';
import 'IFormatter.dart';

class ArgumentListFormatter extends IFormatter
{
    static const String CLASS_NAME = 'ArgumentListFormatter';

    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ArgumentListFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        if (Constants.DEBUG_I_FORMATTER) log('START $CLASS_NAME(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! ArgumentList)
            throw FormatException('Not an ArgumentList: ${node.runtimeType}');

        final Copier copier = Copier(astVisitor, config, formatState, node);
        final bool isBlockPattern = _isBlockPattern(node);

        copier.copyEntity(node.leftParenthesis, '$CLASS_NAME/node.leftParenthesis', Spacing.zero);
        if (!isBlockPattern)
            formatState.pushLevel('$CLASS_NAME/node.leftParenthesis');

        copier.acceptListWithComma(node.arguments, node.rightParenthesis, '$CLASS_NAME/node.arguments', leadingSpaces: config.space0, trimCommaText: config.fixSpaces);
        if (!isBlockPattern)
            formatState.popLevelAndIndent();

        copier.copyEntity(node.rightParenthesis, '$CLASS_NAME/node.rightParenthesis', Spacing.zero);

        if (Constants.DEBUG_I_FORMATTER) log('END   $CLASS_NAME(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
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
