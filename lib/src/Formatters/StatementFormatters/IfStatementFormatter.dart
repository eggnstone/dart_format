import 'package:analyzer/dart/ast/ast.dart';

import '../../Config.dart';
import '../../Constants.dart';
import '../../FormatState.dart';
import '../../Tools/StringTools.dart';
import '../../Types/IndentationType.dart';
import '../IFormatter.dart';

class IfStatementFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    IfStatementFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'IfStatementFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! IfStatement)
            throw FormatException('Not an IfStatement: ${node.runtimeType}');

        formatState.copyEntity(node.ifKeyword, astVisitor, '$methodName/node.ifKeyword'); // covered by tests
        formatState.copyEntity(node.leftParenthesis, astVisitor, '$methodName/node.leftParenthesis'); // covered by tests
        formatState.copyEntity(node.expression, astVisitor, '$methodName/node.expression'); // covered by tests
        formatState.copyEntity(node.rightParenthesis, astVisitor, '$methodName/node.rightParenthesis'); // covered by tests

        formatState.pushLevel('$methodName/node.thenStatement', IndentationType.single); // covered by tests
        formatState.copyEntity(node.thenStatement, astVisitor, '$methodName/node.thenStatement'); // covered by tests
        formatState.popLevelAndIndent(); // covered by tests

        if (node.elseKeyword == null)
            return;

        final bool indentElse = node.elseStatement is! IfStatement; // covered by tests

        formatState.copyEntity(node.elseKeyword, astVisitor, '$methodName/node.elseKeyword'); // covered by tests
        if (indentElse) // covered by tests
            formatState.pushLevel('$methodName/node.elseKeyword', IndentationType.single); // covered by tests

        formatState.copyEntity(node.elseStatement, astVisitor, '$methodName/node.elseStatement'); // covered by tests

        if (indentElse) // covered by tests
            formatState.popLevelAndIndent(); // covered by tests
    }
}
