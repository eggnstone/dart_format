import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import '../Types/IndentationType.dart';
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
        log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! SwitchPatternCase)
            throw FormatException('Not a SwitchPatternCase: ${node.runtimeType}');

        formatState.copyEntity(node.keyword, astVisitor, '$methodName/node.keyword'); // covered by tests
        formatState.copyEntity(node.guardedPattern, astVisitor, '$methodName/node.guardedPattern'); // covered by tests
        formatState.copyEntity(node.colon, astVisitor, '$methodName/node.colon'); // covered by tests
        formatState.pushLevel('$methodName/node.statements', IndentationType.multiple); // covered by tests
        formatState.acceptList(node.statements, astVisitor, '$methodName/node.statements'); // covered by tests
        formatState.popLevelAndIndent(); // covered by tests

        log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
