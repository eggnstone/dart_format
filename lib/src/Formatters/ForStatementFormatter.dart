import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class ForStatementFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ForStatementFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ForStatementFormatter.format';
        log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! ForStatement)
            throw FormatException('Not a ForStatement: ${node.runtimeType}');

        formatState.copyEntity(node.forKeyword, astVisitor, '$methodName/node.forKeyword');
        formatState.copyEntity(node.leftParenthesis, astVisitor, '$methodName/node.leftParenthesis');
        formatState.copyEntity(node.forLoopParts, astVisitor, '$methodName/node.forLoopParts');
        formatState.copyEntity(node.rightParenthesis, astVisitor, '$methodName/node.rightParenthesis');
        formatState.pushLevel('$methodName/node.body');
        formatState.copyEntity(node.body, astVisitor, '$methodName/node.body');
        formatState.popLevelAndIndent();

        log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
