// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../SimpleStack.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class SwitchPatternCaseFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    SwitchPatternCaseFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'SwitchPatternCaseFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node)})', formatState.logIndent++);

        if (node is! SwitchPatternCase)
            throw FormatException('Not a SwitchPatternCase: ${node.runtimeType}');

        formatState.acceptList(node.labels, astVisitor, '$methodName/node.labels');
        formatState.copyEntity(node.keyword, astVisitor, onGetStack: () => SimpleStack('$methodName/node.keyword'));
        formatState.copyEntity(node.guardedPattern, astVisitor, onGetStack: () => SimpleStack('$methodName/node.guardedPattern'));
        formatState.copyEntity(node.colon, astVisitor, onGetStack: () => SimpleStack('$methodName/node.colon'));
        formatState.pushLevel('$methodName/node.statements');
        formatState.acceptList(node.statements, astVisitor, '$methodName/node.statements');
        formatState.popLevelAndIndent();

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node)})', --formatState.logIndent);
    }
}
