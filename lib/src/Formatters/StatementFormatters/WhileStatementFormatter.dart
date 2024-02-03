import 'package:analyzer/dart/ast/ast.dart';

import '../../Config.dart';
import '../../Constants.dart';
import '../../FormatState.dart';
import '../../Tools/StringTools.dart';
import '../../Types/IndentationType.dart';
import '../IFormatter.dart';

class WhileStatementFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    WhileStatementFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'WhileStatementFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! WhileStatement)
            throw FormatException('Not a WhileStatement: ${node.runtimeType}');

        formatState.copyEntity(node.whileKeyword, astVisitor, '$methodName/node.whileKeyword'); // covered by tests
        formatState.copyEntity(node.leftParenthesis, astVisitor, '$methodName/node.leftParenthesis'); // covered by tests
        formatState.copyEntity(node.condition, astVisitor, '$methodName/node.condition'); // covered by tests
        formatState.copyEntity(node.rightParenthesis, astVisitor, '$methodName/node.rightParenthesis'); // covered by tests
        formatState.pushLevel('$methodName/node.body', IndentationType.single); // covered by tests
        formatState.copyEntity(node.body, astVisitor, '$methodName/node.body'); // covered by tests
        formatState.popLevelAndIndent(); // covered by tests
    }
}
