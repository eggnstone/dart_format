// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

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
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ArgumentListFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ArgumentListFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! ArgumentList)
            throw FormatException('Not an ArgumentList: ${node.runtimeType}');

        final Copier copier = Copier(astVisitor, config, formatState, node);

        copier.copyEntity(node.leftParenthesis,  '$methodName/node.leftParenthesis', Spacing.zero);
        formatState.pushLevel('$methodName/node.leftParenthesis');
        copier.acceptListWithComma(node.arguments, node.rightParenthesis, '$methodName/node.arguments', leadingSpaces: config.space0, trimCommaText: config.fixSpaces);
        formatState.popLevelAndIndent();
        copier.copyEntity(node.rightParenthesis,  '$methodName/node.rightParenthesis', Spacing.zero);

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
