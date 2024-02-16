/*
import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class ForElementFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ForElementFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ForElementFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! ForElement)
            throw FormatException('Not a ForElement: ${node.runtimeType}');

        formatState.copyEntity(node.awaitKeyword, astVisitor, '$methodName/node.awaitKeyword');
        formatState.copyEntity(node.forKeyword, astVisitor, '$methodName/node.forKeyword');
        formatState.copyEntity(node.leftParenthesis, astVisitor, '$methodName/node.leftParenthesis');
        formatState.copyEntity(node.forLoopParts, astVisitor, '$methodName/node.forLoopParts');
        formatState.copyEntity(node.rightParenthesis, astVisitor, '$methodName/node.rightParenthesis');
        formatState.copyEntity(node.body, astVisitor, '$methodName/node.body');
    }
}
*/
