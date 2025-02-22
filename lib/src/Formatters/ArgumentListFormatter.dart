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

        copier.copyEntity(node.leftParenthesis,  '$CLASS_NAME/node.leftParenthesis', Spacing.zero);
        formatState.pushLevel('$CLASS_NAME/node.leftParenthesis');
        copier.acceptListWithComma(node.arguments, node.rightParenthesis, '$CLASS_NAME/node.arguments', leadingSpaces: config.space0, trimCommaText: config.fixSpaces);
        formatState.popLevelAndIndent();
        copier.copyEntity(node.rightParenthesis,  '$CLASS_NAME/node.rightParenthesis', Spacing.zero);

        if (Constants.DEBUG_I_FORMATTER) log('END   $CLASS_NAME(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
