import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class IfElementFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    IfElementFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'IfElementFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! IfElement)
            throw FormatException('Not an IfElement: ${node.runtimeType}');

        formatState.copyEntity(node.ifKeyword, astVisitor, '$methodName/node.ifKeyword');
        formatState.copyEntity(node.leftParenthesis, astVisitor, '$methodName/node.leftParenthesis');
        formatState.copyEntity(node.expression, astVisitor, '$methodName/node.expression');
        formatState.copyEntity(node.rightParenthesis, astVisitor, '$methodName/node.rightParenthesis');
        formatState.copyEntity(node.thenElement, astVisitor, '$methodName/node.thenElement');
        formatState.copyEntity(node.elseKeyword, astVisitor, '$methodName/node.elseKeyword');
        formatState.copyEntity(node.elseElement, astVisitor, '$methodName/node.elseElement');
    }
}
