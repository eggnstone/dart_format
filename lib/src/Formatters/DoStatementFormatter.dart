import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class DoStatementFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    DoStatementFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'DoStatementFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! DoStatement)
            throw FormatException('Not a DoStatement: ${node.runtimeType}');

        formatState.copyEntity(node.doKeyword, astVisitor, '$methodName/node.doKeyword');
        formatState.copyEntity(node.body, astVisitor, '$methodName/node.body');
        formatState.copyEntity(node.whileKeyword, astVisitor, '$methodName/node.whileKeyword');
        formatState.copyEntity(node.leftParenthesis, astVisitor, '$methodName/node.leftParenthesis');
        formatState.copyEntity(node.condition, astVisitor, '$methodName/node.condition');
        formatState.copyEntity(node.rightParenthesis, astVisitor, '$methodName/node.rightParenthesis');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon');
    }
}
