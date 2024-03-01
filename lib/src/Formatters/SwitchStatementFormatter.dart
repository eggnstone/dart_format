// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../SimpleStack.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class SwitchStatementFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    SwitchStatementFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'SwitchStatementFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node)})', formatState.logIndent++);

        if (node is! SwitchStatement)
            throw FormatException('Not a SwitchStatement: ${node.runtimeType}');

        formatState.copyEntity(node.switchKeyword, astVisitor, onGetStack: () => SimpleStack('$methodName/node.switchKeyword'));
        formatState.copyEntity(node.leftParenthesis, astVisitor, onGetStack: () => SimpleStack('$methodName/node.leftParenthesis'));
        formatState.copyEntity(node.expression, astVisitor, onGetStack: () => SimpleStack('$methodName/node.expression'));
        formatState.copyEntity(node.rightParenthesis, astVisitor,onGetStack: () => SimpleStack('$methodName/node.rightParenthesis'));
        formatState.copyOpeningBraceAndPushLevel(node.leftBracket, config, '$methodName/node.leftBracket');
        formatState.acceptList(node.members, astVisitor, '$methodName/node.members');
        formatState.copyClosingBraceAndPopLevel(node.rightBracket, config, '$methodName/node.rightBracket');

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node)})', --formatState.logIndent);
    }
}
